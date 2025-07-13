import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ConditionCheckBox extends StatelessWidget {
  const ConditionCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController){
      return Row(
          mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          width: 24.0,
          child: Checkbox(
            activeColor: Theme.of(context).colorScheme.primary,
            value: authController.acceptTerms??false,
            onChanged: (bool? isChecked) => authController.toggleTerms(),
          ),
        ),
        Text('i_agree_with_the'.tr, style: ubuntuRegular.copyWith(
          fontSize: Dimensions.fontSizeSmall,
          color: Theme.of(context).colorScheme.primary,
        )),
        InkWell(
          onTap: () => Get.toNamed(RouteHelper.getHtmlRoute('terms-and-condition')),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Text('terms_and_conditions'.tr, style: ubuntuBold.copyWith(
              fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,
            )),
          ),
        ),
      ]);
    });
  }
}
