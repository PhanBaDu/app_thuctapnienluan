import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getSearchData(String query) async {
    return await apiClient.getData('${AppConstants.searchUrl}?search=$query&offset=1&limit=50');
  }


  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.searchHistory, searchHistories);
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.searchHistory) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.searchHistory, []);
  }
}
