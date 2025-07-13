import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class PaymentFailedDialog extends StatelessWidget {
  final String? orderID;
  PaymentFailedDialog({super.key, required this.orderID});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Image.asset(Images.paymentFail, width: 70, height: 70),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              'payment_failed'.tr, textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical: Dimensions.paddingSizeSmall),
            child: Text(
              'it_seems_enrolment_is_not_completed'.tr, textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          TextButton(
            onPressed: () {
              Get.offAllNamed(RouteHelper.getInitialRoute());
              },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error, // your color here
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault)))),
            child: Text('please_try_again_later'.tr, textAlign: TextAlign.center, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color)),
          ),

        ]),
      )),
    );
  }
}
