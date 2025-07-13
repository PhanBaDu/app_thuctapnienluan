import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? description;
  final Function()? onYesPressed;
  final bool? isLogOut;
  final Function? onNoPressed;
  final Widget? widget;
  const ConfirmationDialog({super.key, @required this.icon, this.title, @required this.description, @required this.onYesPressed,
    this.isLogOut = false, this.onNoPressed, this.widget});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: widget ?? Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Image.asset(icon!, width: 50, height: 50),
          ),
          title != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ):
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Text(description!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          GetBuilder<UserController>(builder: (userController){
            return userController.isLoading ? const Center(child: CircularProgressIndicator(),): Row(children: [
              Expanded(child: TextButton(
                onPressed: () => isLogOut! ? onYesPressed!() : onNoPressed != null ? onNoPressed!() : Get.back(),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(width, 45), padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                ),
                child: Text(
                  isLogOut! ? 'yes'.tr : 'no'.tr, textAlign: TextAlign.center,
                  style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              )),
              const SizedBox(width: Dimensions.paddingSizeLarge),
              Expanded(child: CustomButton(
                buttonText: isLogOut! ? 'no'.tr : 'yes'.tr,
                fontSize: Dimensions.fontSizeSmall,
                onPressed: () => isLogOut! ? Get.back() : onYesPressed!(),
                radius: Dimensions.radiusSmall, height: 45,
              )),
            ]);
          },),

        ]),
      )),
    );
  }
}
