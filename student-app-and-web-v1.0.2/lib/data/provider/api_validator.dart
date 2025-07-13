import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';

class ApiValidator {
  static void validateApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      Get.offAllNamed(RouteHelper.getSignInRoute('splash'));
    }else{
      customSnackBar("${response.statusCode!}".tr);
    }
  }
}