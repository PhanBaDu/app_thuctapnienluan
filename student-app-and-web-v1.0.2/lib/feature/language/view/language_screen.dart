import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/language/widgets/language_widget.dart';
import 'package:get_lms_flutter/feature/menu/model/menu_model.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/gaps.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class LanguageScreen extends StatelessWidget {
  final String fromPage;

  const LanguageScreen({Key? key, required this.fromPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    final List<MenuModel> _menuList = [
      MenuModel(icon: Images.profile, title: 'profile'.tr, route: RouteHelper.getProfileRoute('languageScreen')),
      MenuModel(icon: Images.customerCare, title: 'help_&_support'.tr, route: RouteHelper.getSupportRoute()),
    ];
    _menuList.add(MenuModel(icon: Images.logout, title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return Scaffold(
      appBar:fromPage == "fromSettingsPage" ? CustomAppBar(title: "language".tr) : null,
      body: GetBuilder<LocalizationController>(
        builder: (localizationController){
          return Container(
            width: Dimensions.webMaxWidth,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gaps.verticalGapOf(Dimensions.paddingSizeExtraLarge),
                    if(fromPage != "fromSettingsPage")
                      Image.asset(
                        Images.logo,
                        height: 100,
                        width: 100,
                      ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    Align(
                        alignment:Get.find<LocalizationController>().isLtr ?  Alignment.centerLeft : Alignment.centerRight,
                        child: Text('select_language'.tr,style: ubuntuMedium,)),
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 3 : 1,
                        childAspectRatio:ResponsiveHelper.isDesktop(context) ? (1/1):5,
                      ),
                      itemCount: localizationController.languages.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      itemBuilder: (context, index) => LanguageWidget(
                        languageModel: localizationController.languages[index],
                        localizationController: localizationController, index: index,
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                      onPressed: (){
                        Get.find<SplashController>().saveSplashSeenValue(true);
                        localizationController.setLanguage(Locale(
                          AppConstants.languages[localizationController.selectedIndex].languageCode!,
                          AppConstants.languages[localizationController.selectedIndex].countryCode,
                        ));
                        if(fromPage != 'fromSettingsPage'){
                          Get.offNamed(RouteHelper.onBoardScreen);
                        }else{
                          Get.back();
                        }
                      },
                      buttonText: 'save'.tr)),
              SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : 0),
            ]),
          );
        },
      ),
    );
  }
}
