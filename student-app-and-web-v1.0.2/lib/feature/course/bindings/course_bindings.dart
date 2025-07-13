import 'package:get/get.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/repository/course_repo.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceBinding extends Bindings{
  @override
  void dependencies() async {

    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => CourseController(
        serviceRepo: CourseRepo(apiClient: ApiClient(
           appBaseUrl: AppConstants.baseUrl,
           sharedPreferences: sharedPreferences))
    ));
  }
}