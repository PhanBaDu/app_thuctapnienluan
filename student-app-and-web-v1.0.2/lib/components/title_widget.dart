import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class TextTitle extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const TextTitle({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodySmall!.color)),
      (onTap != null) ? InkWell(
        onTap: onTap,
        child: Text(
          'see_all'.tr,
          style: ubuntuMedium.copyWith(
            decoration: TextDecoration.underline,
            color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
            fontSize: Dimensions.fontSizeDefault, ),

        ),
      ) : const SizedBox(),
    ]);
  }
}
