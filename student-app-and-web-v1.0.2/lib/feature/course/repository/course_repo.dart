import 'package:get/get.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class CourseRepo extends GetxService {
  final ApiClient apiClient;
  CourseRepo({required this.apiClient});

  Future<Response> getAllCourseList(int offset) async {
    return await apiClient.getData('${AppConstants.allCourseUrl}?offset=$offset&limit=10');
  }
  Future<Response> getPopularServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.popularCourseUri}?offset=$offset&limit=10');
  }

  Future<Response> getInstructorBasedCourseList(int offset, String instructorID) async {
    return await apiClient.getData('${AppConstants.popularCourseUri}$instructorID?offset=$offset&limit=10');
  }

  Future<Response> getCoursesBasedOnCategory({required String categoryID, required int offset}) async {
    return await apiClient.getData('${AppConstants.courseBasedOnCategory}$categoryID?limit=10&offset=$offset');
  }

  Future<Response> getServiceListBasedOnSubCategory({required String subCategoryID, required int offset}) async {
    return await apiClient.getData('${AppConstants.courseBasedOnSubCategory}$subCategoryID?limit=10&offset=$offset');
  }

  Future<Response> getCourseDetails(String serviceID) async {
    return await apiClient.getData('${AppConstants.courseDetailsUri}/$serviceID');
  }

}
