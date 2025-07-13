import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/bottomNav/controller/bottom_nav_controller.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/category/repository/category_repo.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/repository/course_repo.dart';
import 'package:get_lms_flutter/feature/home/controller/banner_controller.dart';
import 'package:get_lms_flutter/feature/home/repository/banner_repo.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/repository/user_repo.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => BannerController(bannerRepo: BannerRepo(apiClient: Get.find())));
    Get.lazyPut(() => CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => CourseController(serviceRepo: CourseRepo(apiClient:Get.find())));
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
  }
}