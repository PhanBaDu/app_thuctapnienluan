export 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnrolmentRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  EnrolmentRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getEnrolmentList({required int offset}) async {
    return await apiClient.getData(AppConstants.enrolmentList);
  }

  Future<Response> getEnrolmentDetails({required int id}) async {
    return await apiClient.getData("${AppConstants.enrolmentDetails}$id");
  }


}
