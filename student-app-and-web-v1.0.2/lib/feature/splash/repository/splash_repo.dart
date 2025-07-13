import 'package:get/get.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({ required this.apiClient, required this.sharedPreferences});

  Future<Response> getConfigData() async {
    Response _response = await apiClient.getData(AppConstants.configUrl);
    // printLog(_response.body);
    return _response;
  }

  Future<bool> initSharedData() async {

    if(!sharedPreferences.containsKey(AppConstants.theme)) {
      sharedPreferences.setBool(AppConstants.theme, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.currencyCode)) {
      sharedPreferences.setString(AppConstants.currencyCode, AppConstants.languages[0].countryCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.languageCode)) {
      sharedPreferences.setString(AppConstants.languageCode, AppConstants.languages[0].languageCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.cartList)) {
      sharedPreferences.setStringList(AppConstants.cartList, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.searchHistory)) {
      sharedPreferences.setStringList(AppConstants.searchHistory, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.notification)) {
      sharedPreferences.setBool(AppConstants.notification, true);
    }
    if(!sharedPreferences.containsKey(AppConstants.notificationCount)) {
      sharedPreferences.setInt(AppConstants.notificationCount, 0);
    }

    return Future.value(true);
  }


  Future<bool> setSplashSeen(bool isSplashSeen) async {
    return await sharedPreferences.setBool(AppConstants.isSplashSeen, isSplashSeen);
  }

  /// User address / service location info
  bool isSplashSeen() {
    return sharedPreferences.getBool(AppConstants.isSplashSeen) != null ? sharedPreferences.getBool(AppConstants.isSplashSeen)! : false;
  }

}
