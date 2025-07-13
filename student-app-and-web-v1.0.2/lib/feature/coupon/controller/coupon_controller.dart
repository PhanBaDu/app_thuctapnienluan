import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/coupon/model/coupon_model.dart';
import 'package:get_lms_flutter/feature/coupon/repo/coupon_repo.dart';


class CouponController extends GetxController implements GetxService {
  final CouponRepo couponRepo;
  CouponController({required this.couponRepo});



  bool _isLoading = false;
  Coupon? _coupon;

  bool get isLoading => _isLoading;
  Coupon? get coupon => _coupon;

  List<Coupon>? _couponList;
  List<Coupon>? get couponList => _couponList;


  var applyCouponController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    applyCouponController.text = '';
  }



  Future<void> getCouponList(int offset) async {
    _isLoading = true;
    final response = await couponRepo.getCouponList(offset: offset);
    if (response.statusCode == 200) {
      _couponList = CouponModel.fromJson(response.body).couponContent!.coupons;
    }
    _isLoading = false;
    update();
  }

  Future<void> applyCoupon(Coupon couponModel) async {
    printLog("inside_apply_coupon");
    Response response = await couponRepo.applyCoupon(couponModel.code!);
    printLog("response_apply_coupon:${response.body}");

    if(response.statusCode == 200 && response.body['status'] == 'success'){
      _coupon = couponModel;
      customSnackBar(response.body['message'], isError: false);
    }else{
      customSnackBar(response.body['message'], isError: true);
    }
    printLog('coupon response : ${response.body}');
    update();
  }




}
