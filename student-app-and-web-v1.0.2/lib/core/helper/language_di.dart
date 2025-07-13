import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/data/model/response/language_model.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/auth/repository/auth_repo.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/cart/repository/cart_repo.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/repository/user_repo.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/feature/splash/repository/splash_repo.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, Map<String, String>>> init() async {
  //those binding are used before called GetMaterial app
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: CartRepo(sharedPreferences:Get.find(),apiClient: Get.find())));
  Get.lazyPut(() => AuthController(authRepo: AuthRepo(sharedPreferences:Get.find(),apiClient: Get.find())));
  Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/languages/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return languages;
}