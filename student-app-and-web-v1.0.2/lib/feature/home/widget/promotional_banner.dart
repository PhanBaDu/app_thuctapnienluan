import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';

class PromotionalBanner extends StatelessWidget {
  const PromotionalBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Container(
        width: Get.width,
        height: 130,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Images.dummyBanner),fit: BoxFit.fill)
        ),
      ),
    );
  }
}
