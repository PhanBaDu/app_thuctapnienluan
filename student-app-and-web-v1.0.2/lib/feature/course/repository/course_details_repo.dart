import 'package:get/get.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class CourseDetailsRepo extends GetxService {
  final ApiClient apiClient;
  CourseDetailsRepo({required this.apiClient});

  Future<Response> getCourseDetails(String serviceID) async {
    return await apiClient.getData('${AppConstants.courseDetailsUri}/$serviceID');
  }


}
