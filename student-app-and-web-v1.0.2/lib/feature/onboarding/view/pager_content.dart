import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class PagerContent extends StatelessWidget {
  const PagerContent({Key? key, required this.image, required this.title, required this.subTitle}) : super(key: key);

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox(height: Get.height / 4, child: Image.asset(image)),
        const SizedBox(height: Dimensions.paddingSizeDefault,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(title,
                textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeLarge),),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                child: Text(subTitle,
                  textAlign: TextAlign.center,
                  style: ubuntuRegular.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Dimensions.fontSizeDefault),),
              ),
            ],
          )
        ),
        SizedBox(height: context.height*0.15),
      ],
    );
  }
}