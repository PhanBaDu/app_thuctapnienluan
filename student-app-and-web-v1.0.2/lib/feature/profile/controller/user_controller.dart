import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_lms_flutter/data/model/response/response_model.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/profile/model/userinfo_model.dart';
import 'package:get_lms_flutter/feature/profile/repository/user_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';


class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});


   UserInfoModel? _userInfoModel = UserInfoModel();
   XFile? _pickedFile ;
   FilePickerResult? _selectedFile;
   bool _isLoading = false;

  UserInfoModel get userInfoModel => _userInfoModel!;
  XFile? get pickedFile => _pickedFile;
  bool get isLoading => _isLoading;

  String _createdAccountAgo ='';
  String get createdAccountAgo => _createdAccountAgo;

  String _userProfileImage = '';
  String get userProfileImage => _userProfileImage;

  Future<void> getUserInfo() async {
    if(_userInfoModel == null){
      _isLoading = true;
      Response response = await userRepo.getUserInfo();
      if (response.statusCode == 200) {
        _userInfoModel = UserInfoModel.fromJson(response.body);
        _userProfileImage = _userInfoModel!.image??'';
      } else {
        ApiValidator.validateApi(response);
      }
      _isLoading = false;
      update();
    }

  }

  Future<ResponseModel> changePassword(UserInfoModel updatedUserModel) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await userRepo.changePassword(updatedUserModel);
    if (response.statusCode == 200) {
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(response.body['message']),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    update();
  }


  void pickFile() async {
    _selectedFile = (await FilePicker.platform.pickFiles())!;
    printLog(_selectedFile!.files.single.name);
    update();
  }

  void initData() {
  }
}