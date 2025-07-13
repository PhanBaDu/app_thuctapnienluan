import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class TitleView extends StatelessWidget {
  final String title;
  final bool? isViewAllEnabled;
  const TitleView({Key? key, required this.title, this.isViewAllEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
          if (isViewAllEnabled == true)
            Text(
              'view_all'.tr,
              style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Theme.of(context).colorScheme.primary),
            ),
        ],
      ),
    );
  }
}
