import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/cart/model/cart_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CartServiceWidget extends StatelessWidget {
  final CartModel cart;
  final int cartIndex;

  const CartServiceWidget({super.key,
    required this.cart,
    required this.cartIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeExtraSmall,right: Dimensions.paddingSizeExtraSmall),
      child: Container(
        height: 82.0,
        decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: Get.find<LocalizationController>().isLtr ? 22: null,
                left: Get.find<LocalizationController>().isLtr ? null: 22,
                child: Image.asset(Images.cartDelete,width: 22.0,),),
              Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  if (Get.find<AuthController>().isLoggedIn()) {
                    Get.find<CartController>().removeCartFromServer(cart.id);}
                  else {
                    Get.find<CartController>().removeFromCart(cartIndex);
                  }},
                child:
                Container(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(color: Colors.white.withOpacity(.2)),
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow:Get.isDarkMode ? null:[
                      BoxShadow(
                        color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                        blurRadius: 5,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(RouteHelper.getCourseDetailsRoute(cart.id));
                            },
                            child: SizedBox(
                              width:ResponsiveHelper.isMobile(context)? Get.width / 1.8 : Get.width / 4,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                    child: CustomImage(
                                      image: '${cart.course!.thumbnail}',
                                      height: 65,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cart.course!.title??"",
                                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                          const SizedBox(height: 5),
                                          Text(
                                            PriceFormatter.formatPrice(cart.totalCost),
                                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6)),
                                          ),
                                          const SizedBox(height: 5),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
        ]),
      ),
    );
  }
}
