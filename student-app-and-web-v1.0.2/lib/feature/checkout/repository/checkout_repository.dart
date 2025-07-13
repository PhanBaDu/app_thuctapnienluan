import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutRepository{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  CheckoutRepository({required this.sharedPreferences,required this.apiClient});


  Future<Response> addToEnrolmentID(dynamic cartModel) async {
    return await apiClient.postData(AppConstants.createEnrolment,cartModel);
  }


}