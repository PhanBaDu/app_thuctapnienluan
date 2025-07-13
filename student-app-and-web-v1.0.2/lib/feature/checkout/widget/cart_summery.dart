import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/cart/model/cart_model.dart';
import 'package:get_lms_flutter/feature/checkout/widget/row_text.dart';
import 'package:get_lms_flutter/feature/coupon/controller/coupon_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CartSummery extends GetView<CartController> {
  const CartSummery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
        builder: (couponControllers){
        return GetBuilder<CartController>(
          builder: (cartController){
            List<CartModel> cartList = cartController.cartList;
            ///total and discount price will be calculated from all cart item price

            double? subTotalPrice = 0.0;
            double? disCount = 0.0;
            double? campaignDisCount = 0;
            double? couponDisCount = 0;
            double? vat = 0;
            for (var cartModel in cartController.cartList) {
              subTotalPrice = subTotalPrice! + (cartModel.courseCost * cartModel.quantity); //(without any discount and coupons)
              disCount = disCount! + cartModel.discountedPrice ;
              campaignDisCount = campaignDisCount! + cartModel.campaignDiscountPrice;
              couponDisCount = couponDisCount! + cartModel.couponDiscountPrice;

              vat = vat! + (cartModel.taxAmount );

            }
            double? grandTotal = (subTotalPrice!  - (couponDisCount! + disCount! + campaignDisCount!)) + vat!;

            if(grandTotal.toInt() > 0){
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text(
                      'cart_summary'.tr,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: cartList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              double totalCost = cartList.elementAt(index).courseCost * cartList.elementAt(index).quantity;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RowText(title: cartList.elementAt(index).course!.title!, quantity: cartList.elementAt(index).quantity, price: totalCost),
                                  const SizedBox(height: Dimensions.paddingSizeDefault,)
                                ],
                              );
                            },
                          ),
                          Divider(
                            height: 1,
                            color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                          RowText(title: 'sub_total'.tr, price: subTotalPrice),
                          RowText(title: 'discount'.tr, price: disCount),
                          RowText(title: 'campaign_discount'.tr, price: campaignDisCount),
                          RowText(title: 'coupon_discount'.tr, price: couponDisCount),
                          RowText(title: 'vat'.tr, price: vat),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Divider(
                            height: 1,
                            color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          RowText(title:'grand_total'.tr , price: grandTotal),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                  ],
                ),
              );
            }else{
              return Container();
            }
          }
        );
      }
    );
  }
}
