export 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseResourceRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CourseResourceRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getCourseResourceList({required String courseID}) async {
    return await apiClient.getData("${AppConstants.lessonResource}$courseID");
  }


}
