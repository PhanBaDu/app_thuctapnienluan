import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ColumnText extends StatelessWidget {
  final String accountAgo;
  final bool isProfileTimeAgo;
  final int amount;
  final String title;
  const ColumnText({Key? key,required this.title,required this.amount,  this.accountAgo ='',  this.isProfileTimeAgo = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.isDesktop(context) ? Dimensions.webMaxWidth * .40 : Get.width * .40,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isProfileTimeAgo? accountAgo.replaceAll('days ago', 'days_ago'.tr).replaceAll('minutes ago', 'replace'.tr).replaceAll('hours ago', 'hours_ago'.tr):
              amount.toString(),
              style: ubuntuBold.copyWith(fontSize: 16,
                  // color:  Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6)
                  color:  Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(
                fontSize: 12,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
