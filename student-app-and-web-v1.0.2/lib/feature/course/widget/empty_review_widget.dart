import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class EmptyReviewWidget extends StatelessWidget {
  const EmptyReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Dimensions.webMaxWidth,
        constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
          minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
        ) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            Image.asset(Images.emptyReview,scale:Dimensions.paddingSizeSmall,color: Get.isDarkMode ?  Theme.of(context).primaryColorLight: Theme.of(context).primaryColor,),
            const SizedBox(height: 20.0,),
            Text("no_review_yet".tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),),
          ],
        ),
      ),
    );
  }
}
