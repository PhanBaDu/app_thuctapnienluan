export 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  MeetingRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getMeetingList({required int offset}) async {
    return await apiClient.getData(AppConstants.meetingList);
  }


}
