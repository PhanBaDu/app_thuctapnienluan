export 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLearningRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  MyLearningRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getMyLearningResource({required int offset,required int courseID}) async {
    return await apiClient.getData("${AppConstants.learningResource}$courseID");
  }

  Future<Response> getAssignmentList({required int offset,required int courseID}) async {
    return await apiClient.getData("${AppConstants.assignmentList}$courseID");
  }


  Future<Response> submitAssignment(String assignmentID, XFile? data) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      '_method': 'put'
    });
    return await apiClient.postMultipartData("${AppConstants.submitAssignment}$assignmentID", body,data != null ? [MultipartBody('submission_file', data)]:[]);
  }

  Future<Response> lessonMarkAsComplete(String lessonID) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      '_method': 'put'
    });
    return await apiClient.postData("${AppConstants.lessonMarkAsComplete}$lessonID", body);
  }

  Future<Response> lastViewedLesson(String courseId, String sectionID, String lessonID) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      'last_viewed_course': courseId,
      'last_viewed_section': sectionID,
      'last_viewed_lesson': lessonID,
    });
    print(body);
    return await apiClient.postData(AppConstants.lastViewedCourse, body);
  }

  Future<Response> getLastViewedCourse() async {
    return await apiClient.getData(AppConstants.lastViewedCourse);
  }

  Future<Response> getCertificate({required String courseID}) async {
    return await apiClient.getData("${AppConstants.certificate}$courseID");
  }

}
