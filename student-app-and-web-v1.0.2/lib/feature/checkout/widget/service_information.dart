import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ServiceInformation extends StatelessWidget {
  const ServiceInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween, crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text('service_address'.tr),

                ],
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge,),
            Container(
              color: Theme.of(context).hoverColor,
              width: Get.width,

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('service_address'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    Text('select_your_address'.tr),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault,),
      ],
    );
  }
}
