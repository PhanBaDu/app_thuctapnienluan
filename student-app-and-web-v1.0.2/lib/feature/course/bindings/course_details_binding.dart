import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/course/controller/course_details_controller.dart';
import 'package:get_lms_flutter/feature/course/controller/course_details_tab_controller.dart';
import 'package:get_lms_flutter/feature/course/repository/course_details_repo.dart';

class ServiceDetailsBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => CourseDetailsController(serviceDetailsRepo: CourseDetailsRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceTabController(serviceDetailsRepo: CourseDetailsRepo(apiClient: Get.find())));
  }
}