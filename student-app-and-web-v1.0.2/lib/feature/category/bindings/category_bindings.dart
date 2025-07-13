import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/repository/course_repo.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => CourseController(serviceRepo: CourseRepo(apiClient: Get.find())));

  }
}