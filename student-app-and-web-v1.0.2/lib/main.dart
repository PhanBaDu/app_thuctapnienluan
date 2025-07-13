import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/initial_binding/initial_binding.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/messages.dart';
import 'controller/localization_controller.dart';
import 'core/helper/language_di.dart' as di;
import 'core/helper/notification_helper.dart';
import 'core/helper/responsive_helper.dart';
import 'core/helper/route_helper.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'feature/auth/controller/auth_controller.dart';
import 'feature/splash/controller/splash_controller.dart';
import 'firebase_options.dart';



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if(ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  if(GetPlatform.isWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBv72hFs4-Be3BTdDiJyXEBSbelcxGBLBc",
            appId: "appId",
            messagingSenderId: '96083917262',
            projectId: 'get-lms-flutter')
    );
  }else{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Map<String, Map<String, String>> languages = await di.init();
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        int?  orderID = remoteMessage.notification!.titleLocKey != null ? int.parse(remoteMessage.notification!.titleLocKey!) : null;
        printLog("orderID:$orderID");
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }catch(e) {

  }
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  MyApp({@required this.languages});

  void _route() {
    Get.find<SplashController>().getConfigData().then((bool isSuccess) async {
      if (isSuccess) {
        if (Get.find<AuthController>().isLoggedIn()) {
          Get.find<AuthController>().updateToken();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(GetPlatform.isWeb) {
      Get.find<SplashController>().initSharedData();
      if (Get.find<AuthController>().isLoggedIn()) {
        Get.find<UserController>().getUserInfo();
        Get.find<CartController>().getCartListFromServer();
      } else {
        Get.find<CartController>().getCartData();
      }
      _route();
    }

    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return (GetPlatform.isWeb && splashController.configModel == null) ? SizedBox() : GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
            initialBinding: InitialBinding(),
            theme: themeController.darkTheme ? dark : light,
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
            initialRoute: GetPlatform.isWeb ? RouteHelper.getInitialRoute() : RouteHelper.getSplashRoute(),
            getPages: RouteHelper.routes,
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),
          );
        });
      });
    });
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

