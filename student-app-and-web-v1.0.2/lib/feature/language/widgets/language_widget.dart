import 'package:flutter/material.dart';
import 'package:get_lms_flutter/components/ripple_button.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/data/model/response/language_model.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageWidget({Key? key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        localizationController.setSelectIndex(index);
        localizationController.setLanguage(Locale(
          AppConstants.languages[localizationController.selectedIndex].languageCode!,
          AppConstants.languages[localizationController.selectedIndex].countryCode,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color:Theme.of(context).cardColor,
            border: Border.all(color: localizationController.selectedIndex == index ?
            Theme.of(context).primaryColor:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.08), width: 1),
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max, children: [
            Row(
              children: [
                Image.asset(
                  languageModel.imageUrl!, width: 36, height: 36,
                ),
                const SizedBox(width: Dimensions.paddingSizeLarge),
                Text(languageModel.languageName!, style: ubuntuRegular),
              ],
            ),
            const SizedBox()
          ]),
        ),
      ));
  }
}
