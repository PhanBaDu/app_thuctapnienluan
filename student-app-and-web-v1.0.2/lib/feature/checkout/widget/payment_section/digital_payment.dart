import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/feature/checkout/controller/checkout_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class DigitalPayment extends StatelessWidget {
  final String paymentGateway;
  final bool isSelected;

  const DigitalPayment({Key? key, required this.paymentGateway, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<CheckOutController>().updateSelectedPaymentMethod(paymentGateway);

      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          border: Border.all(color: isSelected? Theme.of(context).primaryColor:Theme.of(context).cardColor)
        ),
        child: Row(
          children: [
            CustomImage(
              image: "assets/images/paypal.png",
              placeholder: paymentImage[paymentGateway],
              width: 70,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault),

            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${'digital_payment'.tr} $paymentGateway",
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                    Text(
                      'faster_and_safer_way'.tr,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6)),
                    ),
                    const SizedBox(height: 5),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
