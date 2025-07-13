import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/confirmation_dialog.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/ripple_button.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/model/profile_cart_item_model.dart';
import 'package:get_lms_flutter/feature/profile/widget/profile_card.dart';
import 'package:get_lms_flutter/feature/profile/widget/profile_header.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ProfileScreen extends GetView<UserController> {
  final String fromPage;
  const ProfileScreen({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    final profileCartModelList = [

      ProfileCardItemModel(
        'inbox'.tr, Images.inboxProfile, RouteHelper.getInboxScreenRoute(),
      ),

      ProfileCardItemModel(
        'meetings'.tr, Images.coupons, RouteHelper.getMeetingScreen(),
      ),

      ProfileCardItemModel(
        'enroll_history'.tr, Images.enrollHistory, RouteHelper.getEnrolmentList(),
      ),
      ProfileCardItemModel(
        'coupons'.tr, Images.coupons, RouteHelper.getCouponList(),
      ),
      ProfileCardItemModel(
        'terms_and_conditions'.tr, Images.termsConditions, RouteHelper.getHtmlRoute('terms-and-condition'),
      ),
      ProfileCardItemModel(
        'privacy_and_policy'.tr, Images.privacyPolicy, RouteHelper.getHtmlRoute('privacy-policy'),
      ),
      ProfileCardItemModel(
        'help_and_support'.tr, Images.helpAndSupport, RouteHelper.getSupportRoute(),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'profile'.tr,
        centerTitle: true,
        bgColor: Theme.of(context).primaryColor,
        isBackButtonExist:fromPage == 'bottomNav' ? false: true,
      ),

      body: GetBuilder<UserController>(
        initState: (state){
          if(isLoggedIn){
            Get.find<UserController>().getUserInfo();
          }
        },

        builder: (userController) {
          return userController.isLoading ?
          const Center(child: CircularProgressIndicator()) :
          FooterBaseWidget(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileHeader(userInfoModel: userController.userInfoModel,),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
                      childAspectRatio: 6,
                      crossAxisSpacing: Dimensions.paddingSizeExtraLarge,
                      mainAxisSpacing: Dimensions.paddingSizeSmall,
                    ),
                    itemCount: profileCartModelList.length,
                    itemBuilder: (context, index) {
                      return ProfileCardItem(
                        title: profileCartModelList[index].title,
                        leadingIcon: profileCartModelList[index].loadingIcon,
                        onTap: () {
                          if(profileCartModelList[index].routeName == 'sign_out'){
                            if(Get.find<AuthController>().isLoggedIn()) {
                              Get.dialog(ConfirmationDialog(icon: Images.logout, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: () {
                                Get.find<AuthController>().clearSharedData();
                                Get.find<CartController>().clearCartList();
                                Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                              }), useSafeArea: false);
                            }else {
                              Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                            }
                          }else{
                            Get.toNamed(profileCartModelList[index].routeName);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                  Stack(
                    children: [
                      Text(Get.find<AuthController>().isLoggedIn() ? 'sign_out'.tr : 'sign_in'.tr,style: ubuntuMedium.copyWith(color:const Color(0xFF7455F7)),),
                      Positioned.fill(child: RippleButton(onTap: () async {
                        if(Get.find<AuthController>().isLoggedIn()) {
                          Get.dialog(ConfirmationDialog(icon: Images.logout, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: () {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clearCartList();
                            Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                          }), useSafeArea: false);
                        }else {
                          Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                        }
                      }))
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                ],
              ),
            )
          );
        },
      ),
    );
  }
}

