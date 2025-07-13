import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/notification/controller/notification_controller.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize =  const DarwinInitializationSettings();
    var initializationsSettings =  InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (payload) async {
      printLog("payload:$payload");
      try{
        if(payload.payload!.isNotEmpty) {
          Get.toNamed(RouteHelper.getBookingDetailsScreen(payload.payload!));
        }else {
          Get.toNamed(RouteHelper.getNotificationRoute());
        }
      }catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printLog("onMessage: ${message.toMap()}");
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
      if(Get.find<AuthController>().isLoggedIn()) {
        Get.find<NotificationController>().getNotifications(1);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printLog("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try{
        if(message.notification!.titleLocKey != null && message.notification!.titleLocKey!.isNotEmpty) {
          printLog(message.notification!.title);
          printLog(message.notification!.toMap());
          printLog("trying_to_service_screen:${message.notification!.titleLocKey}");
          //todo:navigate to service details screen
        }else {
          Get.toNamed(RouteHelper.getNotificationRoute());
        }
      }catch (e) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    printLog("inside_show_notification");
    if(!GetPlatform.isIOS) {
      String? _title;
      String? _body;
      String? _orderID;
      String? _image;
      if(data) {
        _title = message.data['title'];
        _body = message.data['body'];
        _orderID = message.data['order_id'];
        _image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http') ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;
      }else {
        _title = message.notification!.title;
        _body = message.notification!.body;
        _orderID = message.notification!.titleLocKey;
        if(GetPlatform.isAndroid) {
          _image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http') ? message.notification!.android!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}' : null;
        }else if(GetPlatform.isIOS) {
          _image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http') ? message.notification!.apple!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}' : null;
        }
      }

      if(_image != null && _image.isNotEmpty) {
        try{
          await showBigPictureNotificationHiddenLargeIcon(_title!, _body!, _orderID!, _image, fln);
        }catch(e) {
          await showBigTextNotification(_title!, _body!, _orderID!, fln);
        }
      }else {
        printLog("inside_else");
        // await showBigTextNotification(_title!, _body!, _orderID!, fln);
        await showBigTextNotification("_title!", "_body!", "_orderID!", fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body, String orderID, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'get_lms', 'get_lms', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigTextNotification(String title, String body, String orderID, FlutterLocalNotificationsPlugin fln) async {
    printLog("showBigTextNotification");
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'get_lms', 'get_lms', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String orderID, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'get_lms', 'get_lms',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  printLog("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
}