import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/profile/controller/edit_profile_controller.dart';
import 'package:get_lms_flutter/feature/profile/repository/user_repo.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => EditProfileController(userRepo: UserRepo(apiClient: Get.find())));
  }
}