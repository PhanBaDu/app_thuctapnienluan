import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';

class CourseButtons extends StatelessWidget {
  final Course course;

  const CourseButtons({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CartController>(builder: (cartController){
      bool addToCart = true;
      Get.find<CartController>().setInitialCartList(course);

      return GetBuilder<CourseController>(builder: (courseController){

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child:cartController.isLoading ? const Center(child: CircularProgressIndicator(),):Column(
            children: [
              CustomButton(
                  onPressed: () async {
                    if(addToCart){
                      addToCart = false;
                      if(Get.find<AuthController>().isLoggedIn()){
                        await cartController.addMultipleCartToServer();
                        await cartController.getCartListFromServer();
                        Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
                      }else{
                        cartController.addDataToCart();
                        Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                      }
                    }
                  },
                  buttonText: 'buy_now'.tr),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        if(addToCart){
                          addToCart = false;
                          if(Get.find<AuthController>().isLoggedIn()){
                            await cartController.addMultipleCartToServer();
                            await cartController.getCartListFromServer();
                          }else{
                            cartController.addDataToCart();
                          }
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                            color: Theme.of(context).primaryColor.withOpacity(0.05),
                            border: Border.all(color: Theme.of(context).primaryColor)
                        ),
                        child: Center(child: Text( 'add_to_cart'.tr)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
    });
  }
}
