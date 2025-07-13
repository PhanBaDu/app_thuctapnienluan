import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/data/model/response/language_model.dart';
import 'package:get_lms_flutter/feature/search/widget/custom_check_box.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          isBackButtonExist: true,
          bgColor: Theme.of(context).primaryColor,
          title: 'settings'.tr,
        ),
        body: GetBuilder<LocalizationController>(
          builder: (localizationController){
            return FooterBaseWidget(child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(Images.language, scale: 3),
                                const SizedBox(width: Dimensions.paddingSizeDefault,),
                                Text(
                                  'language'.tr,
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                                ),
                              ],
                            ),

                            SizedBox(
                              width: 110.0,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: AppConstants.languages.elementAt(localizationController.selectedIndex),
                                  items: AppConstants.languages.map((item) => DropdownMenuItem<LanguageModel>(
                                    value: item,
                                    child: Text(
                                      item.languageName!,
                                      style: const TextStyle(fontSize: 14,),
                                    ),
                                  )).toList(),
                                  onChanged: (LanguageModel? newValue){
                                    localizationController.setSelectIndex(AppConstants.languages.indexOf(newValue!));
                                    localizationController.setLanguage(Locale(
                                      newValue.languageCode!,
                                      newValue.countryCode,
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Images.chooseTheme,
                                  scale: 3,
                                ),
                                const SizedBox(width: Dimensions.paddingSizeDefault,),
                                Text(
                                  "choose_theme".tr,
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeDefault,),
                            GetBuilder<ThemeController>(
                              builder: (themeController) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomCheckBox(
                                      key: const Key('light'),
                                      title: 'light'.tr,
                                      value: Get.isDarkMode ? false : true,
                                      onClick: () {
                                        Get.find<ThemeController>().toggleTheme();
                                      },
                                    ),
                                    const SizedBox(width: Dimensions.paddingSizeDefault),
                                    CustomCheckBox(
                                      key: const Key('dark'),
                                      title: 'dark'.tr,
                                      value: Get.isDarkMode ? true : false,
                                      onClick: () {
                                        Get.find<ThemeController>().toggleTheme();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                    Container(
                      height: 70,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        color: Theme.of(context).cardColor,
                        // boxShadow: Get.isDarkMode ?null: cardShadow,
                      ),
                      child: Center(
                        child: ListTile(
                          title: Row(
                            children: [
                              Image.asset(Images.changePassword,width: Dimensions.profileItemSize,),
                              const SizedBox(width: Dimensions.paddingSizeDefault,),
                              Text('change_password'.tr),
                            ],
                          ),
                          onTap: (){
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
        ));
  }
}
