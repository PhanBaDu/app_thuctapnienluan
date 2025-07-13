import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/web_menu_bar.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  final int? status;

  const OrderSuccessfulScreen({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
      body: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(status == 1 ? Images.paymentSuccess : Images.paymentFail, width: 100, height: 100),
        const SizedBox(height: Dimensions.paddingSizeLarge),
        Text(status == 1 ? 'payment_successful'.tr : 'payment_failed'.tr, style: ubuntuMedium.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeLarge),),
        const SizedBox(height: Dimensions.paddingSizeDefault),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical: Dimensions.paddingSizeSmall),
          child: Text(
            'your_enrolment_is_completed'.tr, textAlign: TextAlign.center,
            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CustomButton(
              buttonText: 'let_learning'.tr, onPressed: () => Get.offAllNamed(RouteHelper.getInitialRoute())),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CustomButton(buttonText: 'explore_more_course'.tr, onPressed: () => Get.offAllNamed(RouteHelper.getInitialRoute())),
        ),
      ]))),
    );
  }
}
