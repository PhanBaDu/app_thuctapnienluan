import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/coupon/controller/coupon_controller.dart';
import 'package:get_lms_flutter/feature/coupon/model/coupon_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ApplyCouponWidget extends GetView<CouponController> {
  const ApplyCouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
        builder: (couponController){
          return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('promotions'.tr,style: ubuntuMedium,),
                if(couponController.coupon != null)
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: Row(
                    children: [
                      const Icon(Icons.delete),
                      Text("${'233'}${'is_applied'.tr}",style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5)),),

                    ],
                  ),
                ),

                Row(

                  children: [
                    Expanded(child: Container(
                      height: 45.0,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular( Dimensions.radiusSmall),
                              bottomLeft: Radius.circular( Dimensions.radiusSmall))
                      ),
                      child: TextFormField(
                        decoration:InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none, width: 0),
                          ),
                          isDense: true,
                          filled: true,
                          fillColor:Theme.of(context).cardColor,
                          contentPadding: EdgeInsets.all(Get.find<LocalizationController>().isLtr ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeExtraSmall),
                          hintText: 'enter_code'.tr,
                          hintStyle: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).hintColor.withOpacity(Get.isDarkMode ? .5:1),
                          ),
                        ),
                        controller: couponController.applyCouponController,
                      ),
                    ),),
                    InkWell(
                      onTap: ()async {
                        if(Get.find<AuthController>().isLoggedIn()){
                          bool isValidCoupon = true;
                          if(isValidCoupon) {
                            Get.find<CouponController>().applyCoupon(Coupon(code: couponController.applyCouponController.value.text)).then((value) {
                              Get.find<CartController>().getCartListFromServer();
                            },
                            );
                          }
                        }else{
                          getLMSToast("login_required_to_apply_coupon".tr,Colors.red);
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(topRight: Radius.circular( Dimensions.radiusSmall),bottomRight: Radius.circular( Dimensions.radiusSmall)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: Center(
                              child: Text('apply'.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).cardColor),),
                            )
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
    });
  }
}
