import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/model/userinfo_model.dart';
import 'package:get_lms_flutter/feature/profile/repository/user_repo.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileController extends GetxController with GetSingleTickerProviderStateMixin{

  final UserRepo userRepo;
  EditProfileController({required this.userRepo});

  bool _isLoading = false;
  get isLoading => _isLoading;

  XFile? _pickedProfileImageFile ;
  XFile? get pickedProfileImageFile => _pickedProfileImageFile;


  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  UserInfoModel _userInfoModel=UserInfoModel();
  UserInfoModel get userInfoModel => _userInfoModel;


  @override
  void onInit() {
    super.onInit();
    _userInfoModel = Get.find<UserController>().userInfoModel;
    firstNameController.text = _userInfoModel.fName??'';
    lastNameController.text = _userInfoModel.lName??'';
    emailController.text = _userInfoModel.email??'';
    phoneController.text = _userInfoModel.phone != null ? _userInfoModel.phone!:'';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  Future<void> updateUserProfile() async {
    String numberWithCountryCode = '';
    numberWithCountryCode =  phoneController.value.text;
    bool isValid = true;

    if(isValid){
      UserInfoModel userInfoModel = UserInfoModel(
          fName: firstNameController.value.text,
          lName: lastNameController.value.text,
          email: emailController.value.text,
          phone: phoneController.value.text);

      _isLoading = true;
      Response response = await userRepo.updateProfile(userInfoModel, pickedProfileImageFile);
      if (response.body['status'] == 'success') {
        Get.back();
        customSnackBar('${response.body['message']}', isError: false);
        _isLoading = false;
      }else{
        customSnackBar('${response.body['response_code']}'.tr, isError: false);
      }
      _isLoading = false;
      update();
      Get.find<UserController>().getUserInfo();
    }
  }

  Future<void> updateAccountInfo() async {
    UserInfoModel userInfoModel = UserInfoModel(
        fName: firstNameController.value.text,
        lName: lastNameController.value.text,
        email: emailController.value.text,
        phone: phoneController.value.text,
        password: passwordController.value.text,
        confirmPassword: confirmPasswordController.value.text
    );

    _isLoading = true;
    update();
    Response response = await userRepo.updateAccountInfo(userInfoModel);
    printLog(response.body);
    if (response.statusCode == 200) {
      ///showing success message and navigate to back
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(response.body['message']),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
      Get.back();
      _isLoading = false;
    }
    update();
  }

  void pickProfileImage() async {
    final ImagePicker _picker = ImagePicker();
     _pickedProfileImageFile = await _picker.pickImage(source: ImageSource.gallery);
    printLog(_pickedProfileImageFile!.path);
    update();
  }

  Future<void> removeProfileImage() async {
    _pickedProfileImageFile = null;
  }

  @override
  void onClose() {
    super.onClose();
  }

  validatePassword(String value){
    if(value.length <8){
      return 'password_should_be'.tr;
    }else if(passwordController.text != confirmPasswordController.text && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
      return 'confirm_password_does_not_matched'.tr;
    }
  }


  bool _isDuplicateAccount = false;
  bool get isDuplicateAccount => _isDuplicateAccount;

  bool _isNotInterested = false;
  bool get isNotInterested => _isNotInterested;


  void toggleIsDuplicateAccount() {
    _isDuplicateAccount = !_isDuplicateAccount;
    update();
  }
  void toggleIsNotInterested() {
    _isNotInterested = !_isNotInterested;
    update();
  }
}