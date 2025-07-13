import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/repository/user_repo.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));

  }
}