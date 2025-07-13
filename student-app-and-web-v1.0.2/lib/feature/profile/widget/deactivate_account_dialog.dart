
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/profile/controller/edit_profile_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class DeactivateAccountDialog extends StatefulWidget {
  const DeactivateAccountDialog({super.key});

  @override
  State<DeactivateAccountDialog> createState() => _DeactivateAccountDialogState();
}

class _DeactivateAccountDialogState extends State<DeactivateAccountDialog> {
  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context)) {
      return  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
      );
    }
    return pointerInterceptor();
  }

  pointerInterceptor(){
    return Padding(
        padding: const EdgeInsets.only(top: Dimensions.CART_DIALOG_PADDING),
        child: Container(
          width: Dimensions.webMaxWidth,
          padding: const EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child:  GetBuilder<EditProfileController>(
              builder: (editProfileController) {
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: Image.asset(Images.accountDelete,scale: 3,)),
                            const SizedBox(width: Dimensions.paddingSizeSmall,),
                            Text('deactivate_account'.tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeOverLarge),),
                          ],),
                          const SizedBox(height: Dimensions.paddingSizeLarge,),
                          Text('this_action_can_not_be_reversed'.tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                          const SizedBox(height: Dimensions.paddingSizeLarge,),
                          reasonWidget("Duplicate Account",editProfileController,true),
                          reasonWidget("No longer Interested In This Platform",editProfileController,false),
                          const SizedBox(height: Dimensions.paddingSizeLarge,),
                        ],
                      ),
                      CustomButton(
                        buttonText: "deactivate_account".tr,
                        onPressed: (){
                          // Get.find<AuthController>().clearSharedData();
                          Get.find<AuthController>().deleteAccount();
                          // Get.find<CartController>().clearCartList();
                          // Get.offAllNamed(RouteHelper.getSignInRoute('edit_proile'));
                        },
                      ),
                    ],
                  ),
                );
              }
          ),
        )
    );
  }

  Widget reasonWidget(String title, EditProfileController controller, bool isDuplicate){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.0,
          child: Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value:isDuplicate? controller.isDuplicateAccount:controller.isNotInterested,
            shape: const CircleBorder(),
            onChanged: (bool? isChecked) =>isDuplicate ? controller.toggleIsDuplicateAccount(): controller.toggleIsNotInterested(),
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall,),
        Text(title,style: ubuntuRegular,),
      ],
    );
  }
}
