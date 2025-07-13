import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/checkout/controller/checkout_controller.dart';
import 'package:get_lms_flutter/feature/checkout/repository/checkout_repository.dart';

class CheckoutBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => CheckOutController(checkoutRepository: CheckoutRepository(sharedPreferences: Get.find(), apiClient: Get.find())));
  }

}