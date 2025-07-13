import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/feature/auth/model/signup_body.dart';
import 'package:get_lms_flutter/feature/auth/model/social_log_in_body.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstants.registerUrl, signUpBody.toJson());
  }

  Future<Response?> login(
      {required String phone, required String password}) async {
    return await apiClient.postData(
        AppConstants.loginUrl, {"email": phone, "password": password});
  }

  Future<Response?> loginWithSocialMedia(
      SocialLogInBody socialLogInBody) async {
    return await apiClient.postData(
        AppConstants.socialLoginUrl, socialLogInBody.toJson());
  }

  Future<Response?> deleteAccount() async {
    return await apiClient.deleteData(AppConstants.deleteAccount);
  }

  Future<Response?> updateToken() async {
    printLog("inside_update_token");
    String? deviceToken;
    if (GetPlatform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        deviceToken = await _saveDeviceToken();
      }
    } else {
      deviceToken = await _saveDeviceToken();
    }
    if (!GetPlatform.isWeb) {
      if (GetPlatform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
        }
      } else {
        FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
      }
    }
    return await apiClient.postData(AppConstants.firebaseToken,
        {"_method": "post", "device_token": deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {}
    }
    if (deviceToken != null) {
      printLog('--------Device Token---------- $deviceToken');
    }
    return deviceToken;
  }

  Future<Response?> forgetPassword(String? phone) async {
    return await apiClient
        .postData(AppConstants.forgotPasswordUrl, {"email": phone});
  }

  Future<Response?> verifyToken(String phone, String otp) async {
    printLog("inside_verifyToken");
    printLog(phone.substring(1, phone.length - 1));
    printLog(otp);
    return await apiClient.postData(AppConstants.verifyTokenUrl,
        {"email": phone.substring(1, phone.length - 1), "token": otp});
  }

  Future<Response?> resetPassword(String phoneOrEmail, String otp,
      String password, String confirmPassword) async {
    return await apiClient.postData(
      AppConstants.resetPasswordUrl,
      {
        "_method": "put",
        "phone_or_email": phoneOrEmail,
        "otp": otp,
        "password": password,
        "confirm_password": confirmPassword
      },
    );
  }

  Future<bool?> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(
        token, sharedPreferences.getString(AppConstants.languageCode));
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  ///user address and language code should not be deleted
  bool clearSharedData() {
    if (!GetPlatform.isWeb) {
      // FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);

      apiClient.postData(
          AppConstants.firebaseToken, {"_method": "put", "device_token": '@'});
    }

    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.setStringList(AppConstants.cartList, []);
    apiClient.token = null;
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.userPassword, password);
      await sharedPreferences.setString(AppConstants.userNumber, number);
    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.userNumber) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.userCurrencyCode) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.userPassword) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.notification) ?? true;
  }

  void setNotificationActive(bool isActive) {
    if (isActive) {
      updateToken();
    } else {
      if (!GetPlatform.isWeb) {
        FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.topic);
      }
    }
    sharedPreferences.setBool(AppConstants.notification, isActive);
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    await sharedPreferences.remove(AppConstants.userCurrencyCode);
    return await sharedPreferences.remove(AppConstants.userNumber);
  }
}
