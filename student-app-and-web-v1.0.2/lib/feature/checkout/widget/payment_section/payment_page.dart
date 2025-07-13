import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/checkout/controller/checkout_controller.dart';
import 'package:get_lms_flutter/feature/checkout/widget/apply_coupon_section.dart';
import 'package:get_lms_flutter/feature/checkout/widget/cart_summery.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/gaps.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'digital_payment.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gaps.verticalGapOf(26),
          GetBuilder<CheckOutController>(builder: (controller) {
            List<String>? paymentGateways =
                Get.find<SplashController>().configModel?.paymentGateways!;
            if (paymentGateways != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: GridView.builder(
                  key: UniqueKey(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.paddingSizeLarge,
                    mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.paddingSizeLarge
                        : Dimensions.paddingSizeSmall,
                    childAspectRatio:
                        ResponsiveHelper.isMobile(context) ? 5 : 4,
                    crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
                    mainAxisExtent:
                        ResponsiveHelper.isMobile(context) ? 95 : 125,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: paymentGateways.length,
                  itemBuilder: (context, index) {
                    return GetBuilder<CheckOutController>(
                        builder: (controller) {
                      return DigitalPayment(
                          paymentGateway: paymentGateways[index],
                          isSelected: controller.selectedPaymentMethod ==
                              paymentGateways[index]);
                    });
                  },
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeExtraMoreLarge,
                vertical: Dimensions.paddingSizeExtraMoreLarge,
              ),
              child: Text(
                "Online payment option is unavailable right now",
                textAlign: TextAlign.center,
                style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).colorScheme.error),
              ),
            );
          }),
          const ApplyCouponWidget(),
          const CartSummery(),
        ],
      ),
    );
  }
}
