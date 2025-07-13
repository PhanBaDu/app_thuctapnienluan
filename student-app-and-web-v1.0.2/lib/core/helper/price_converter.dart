import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/core/common_models/coupon_model.dart';

class PriceFormatter {
  static String currencySymbol ='';
  static String getCurrency( BuildContext context) {
    currencySymbol = Get.find<SplashController>().configModel.currencySymbol!;
    return currencySymbol;
  }

  static String formatPrice(double? price, {double? discount, String? discountType, bool isShowLongPrice = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool _isRightSide = Get.find<SplashController>().configModel.currencySymbolPosition == 'right' && Get.find<LocalizationController>().isLtr == true;
    return isShowLongPrice == true ?
    '${_isRightSide ? '' : currencySymbol}'
        '${(price!).toStringAsFixed(int.parse(Get.find<SplashController>().configModel.currencyDecimalPoint!))
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${_isRightSide ? currencySymbol : ''}':

    longToShortPrice('${_isRightSide ? '' : currencySymbol}'
        '${(price!).toStringAsFixed(int.parse(Get.find<SplashController>().configModel.currencyDecimalPoint??'1'))
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${_isRightSide ? currencySymbol : ''}');

  }

  static double convertWithDiscount(double price, double discount, String discountType) {
    if(discountType == 'amount' || discountType == 'mixed') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }


  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : currencySymbol} ${'off'.tr}';
  }
  static String percentageOrAmount(String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : currencySymbol} ${'off'.tr}';  }



 static Discount discountCalculation(Course service, {bool addCampaign = false}) {
    int? _discountAmount = 0;
    String? _discountAmountType;
    return Discount(discountAmount: _discountAmount, discountAmountType: _discountAmountType);
  }

  static double getDiscountToAmount(Discount discount, double amount) {

    double amount0 = 0;
    if(discount.discountAmountType == 'percent') {
     amount0 = (amount * discount.discountAmount!.toDouble()) / 100.0 ;

     if(amount0 > discount.maxDiscountAmount!.toDouble()) {
       amount0 = discount.maxDiscountAmount!.toDouble();
     }

    }else{
      amount0 = discount.discountAmount!.toDouble();
    }
    return amount0;

  }

  static String longToShortPrice(String price){
    return price.length > 15 ?
    "${price.substring(0, 12)}.......${price.substring(price.length - 1,price.length)}":
    price;
  }
}