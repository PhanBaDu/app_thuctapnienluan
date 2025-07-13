import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';

class WebShadowWrap extends StatelessWidget {
  final Widget child;
  const WebShadowWrap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? Padding(
      padding: ResponsiveHelper.isMobile(context) ? EdgeInsets.zero : const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeLarge, horizontal: Dimensions.paddingSizeExtraSmall,
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 380,
        ),
        padding: !ResponsiveHelper.isMobile(context) ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
        decoration: !ResponsiveHelper.isMobile(context) ? BoxDecoration(
          color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
        ) : null,
        width: Dimensions.webMaxWidth,
        child: child,
      ),
    ) : child;
  }
}