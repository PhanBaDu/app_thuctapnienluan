import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/feature/profile/model/userinfo_model.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.studentInfoUrl);
  }

  Future<Response> updateProfile(UserInfoModel userInfoModel, XFile? data) async {
    Map<String, String> _body = Map();
    _body.addAll(<String, String>{
      '_method': 'put',
      'first_name': userInfoModel.fName!,
      'last_name': userInfoModel.lName!,
      'email': userInfoModel.email!,
      'phone': userInfoModel.phone!,
    });
    return await apiClient.postMultipartData(AppConstants.updateProfileUrl, _body,data != null ? [MultipartBody('image', data)]:[]);
  }


  ///userinfo model will be updated !
  Future<Response> updateAccountInfo(UserInfoModel userInfoModel) async {
    Map<String, String> _body = Map();
    _body.addAll(<String, String>{
      '_method': 'put',
      'first_name': userInfoModel.fName!,
      'last_name': userInfoModel.lName!,
      'email': userInfoModel.email!,
      'phone': userInfoModel.phone!,
      'password': userInfoModel.password!,
      'confirm_password': userInfoModel.confirmPassword!,
    });
    return await apiClient.putData(AppConstants.updateProfileUrl, _body);
  }

  Future<Response> changePassword(UserInfoModel userInfoModel) async {
    return await apiClient.postData(AppConstants.updateProfileUrl, {'phone_or_email': userInfoModel.fName, 'otp': userInfoModel.lName,
      'password': userInfoModel.email, 'confirm_password': userInfoModel.phone});
  }

}