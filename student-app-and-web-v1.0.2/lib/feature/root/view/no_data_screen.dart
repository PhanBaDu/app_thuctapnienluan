import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

enum EmptyScreenType {
  cart, notification, order, coupon, others, home, address, booking,search, course, enrolment, meetings
}

class EmptyScreen extends StatelessWidget {
  final EmptyScreenType? type;
  final String? text;
  final bool isShowHomePage;
  const EmptyScreen({super.key, required this.text, this.type,  this.isShowHomePage = true, });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.03),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset((type == EmptyScreenType.cart || type == EmptyScreenType.order) ? Images.emptyCart:
            type == EmptyScreenType.coupon ? Images.emptyCoupon:
            type == EmptyScreenType.notification ? Images.emptyNotification:
            type == EmptyScreenType.booking ? Images.emptyBooking:
            type == EmptyScreenType.course ? Images.emptyCourse:
            type == EmptyScreenType.search ? Images.emptySearchService:
            Images.emptyCourse,
              width: MediaQuery.of(context).size.height*0.15 ,
              height: MediaQuery.of(context).size.height*0.15,
              color: Get.isDarkMode && type == EmptyScreenType.booking ? Theme.of(context).primaryColorLight:null,
            ),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),
      Text(
        type == EmptyScreenType.cart ? 'no_course_in_your_cart'.tr :
        type == EmptyScreenType.order ? 'sorry_your_order_history_is_Empty'.tr :
        type == EmptyScreenType.coupon ? 'no_coupon_available'.tr:
        type == EmptyScreenType.notification ? 'empty_notifications'.tr : text!,
        style: ubuntuMedium.copyWith(
          fontSize: Dimensions.fontSizeDefault,
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: MediaQuery.of(context).size.height*0.04),
    ]);
  }
}
