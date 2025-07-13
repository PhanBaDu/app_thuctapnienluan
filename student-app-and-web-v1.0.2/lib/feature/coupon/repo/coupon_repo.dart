export 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CouponRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getCouponList({required int offset}) async {
    return await apiClient.getData(AppConstants.couponList);
  }

  Future<Response> applyCoupon(String couponCode) async {
    return await apiClient.getData("${AppConstants.applyCoupon}?coupon_code=$couponCode");
  }

  Future<Response> getEnrolmentDetails({required int id}) async {
    return await apiClient.getData("${AppConstants.enrolmentDetails}$id");
  }


}
