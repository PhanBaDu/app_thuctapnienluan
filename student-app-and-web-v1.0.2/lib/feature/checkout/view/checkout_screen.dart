import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/checkout/controller/checkout_controller.dart';
import 'package:get_lms_flutter/feature/checkout/widget/payment_section/payment_page.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:universal_html/html.dart' as html;

import 'payment_screen.dart';

class CheckoutScreen extends GetView<CheckOutController> {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: CustomAppBar(
        title: 'checkout'.tr,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FooterBaseWidget(
                child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),

                      /// Main Body
                      GetBuilder<CheckOutController>(builder: (controller) {
                        return const PaymentPage();
                      }),
                      if (!ResponsiveHelper.isMobile(context))
                        GetBuilder<CheckOutController>(builder: (controller) {
                          return controller.currentPage != PageState.complete
                              ? Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      child: Center(
                                        child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: 'total_price'.tr,
                                            style: ubuntuRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    ' ${PriceFormatter.formatPrice(Get.find<CartController>().totalPrice)}',
                                                style: ubuntuBold.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (controller
                                                .selectedPaymentMethod.length >
                                            2) {
                                          int? enrolmentId = await Get.find<
                                                  CheckOutController>()
                                              .getEnrolmentID();
                                          if (enrolmentId != null &&
                                              enrolmentId > 0) {
                                            String url = '';
                                            url =
                                                '${AppConstants.baseUrl}/payment/${controller.selectedPaymentMethod.replaceAll('_', '-')}/$enrolmentId';

                                            if (GetPlatform.isWeb) {
                                              String hostname = html
                                                  .window.location.hostname!;
                                              String protocol =
                                                  html.window.location.protocol;
                                              String port =
                                                  html.window.location.port;
                                              url =
                                                  '$url?callback=$protocol//$hostname:$port/';
                                              html.window.open(url, "_self");
                                            } else {
                                              url =
                                                  '$url&&callback=${RouteHelper.orderSuccess}?status=';
                                              Get.to(() =>
                                                  PaymentScreen(url: url));
                                            }
                                          }
                                        } else {
                                          customSnackBar(
                                              'no_payment_method_is_selected'
                                                  .tr);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Center(
                                          child: Text(
                                            'let_checkout'.tr,
                                            style: ubuntuMedium.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(
                                        RouteHelper.getInitialRoute());
                                  },
                                  child: Container(
                                    height: 50,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: Center(
                                      child: Text(
                                        'back_to_homepage'.tr,
                                        style: ubuntuMedium.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                        })
                    ],
                  ),
                ),
              ),
            ),
            if (!ResponsiveHelper.isWeb())
              GetBuilder<CheckOutController>(builder: (controller) {
                return controller.currentPage != PageState.complete
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (Get.find<CheckOutController>()
                                      .selectedPaymentMethod
                                      .length >
                                  2) {
                                int? enrolmentId =
                                    await Get.find<CheckOutController>()
                                        .getEnrolmentID();
                                if (enrolmentId != null && enrolmentId > 0) {
                                  String url = '';
                                  url =
                                      '${AppConstants.baseUrl}/payment/${controller.selectedPaymentMethod.replaceAll('_', '-')}/$enrolmentId';
                                  if (GetPlatform.isWeb) {
                                    String hostname =
                                        html.window.location.hostname!;
                                    String protocol =
                                        html.window.location.protocol;
                                    String port = html.window.location.port;
                                    url =
                                        '$url&&callback=$protocol//$hostname:$port';
                                    html.window.open(url, "_self");
                                  } else {
                                    url =
                                        '$url?callback=${RouteHelper.orderSuccess}?status=';
                                    Get.to(() => PaymentScreen(url: url));
                                  }
                                }
                              } else {
                                customSnackBar(
                                    'no_payment_method_is_selected'.tr);
                              }
                            },
                            child: Container(
                              height: 50,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor),
                              child: Center(
                                child: Text(
                                  'let_checkout'.tr,
                                  style: ubuntuMedium.copyWith(
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          Get.offAllNamed(RouteHelper.getInitialRoute());
                        },
                        child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary),
                          child: Center(
                            child: Text(
                              'back_to_homepage'.tr,
                              style: ubuntuMedium.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      );
              })
          ],
        ),
      ),
    );
  }
}
