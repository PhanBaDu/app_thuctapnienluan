import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/model/userinfo_model.dart';
import 'package:get_lms_flutter/feature/profile/widget/column_text.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ProfileHeader extends GetView<UserController> {
  final UserInfoModel userInfoModel;
  const ProfileHeader({Key? key, required this.userInfoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Get.find<AuthController>().isLoggedIn();
    return SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeDefault),
          child: Stack(
            children: [
              SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(150.0)),
                          child: CustomImage(
                            width: 130.0,
                            height: 130.0,
                            image: isLoggedIn
                                ? userInfoModel.image != null
                                    ? "${Get.find<SplashController>().configModel.imageBaseUrl!}/user/profile_image/${userInfoModel.image!}"
                                    : ''
                                : '',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeLarge,
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
                    if (!isLoggedIn)
                      Text(
                        'guest_user'.tr,
                        style: ubuntuBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .color!
                                .withOpacity(.5)),
                      ),
                    if (isLoggedIn &&
                        userInfoModel.fName != null &&
                        userInfoModel.lName != null)
                      Text(
                        "${userInfoModel.fName!} ${userInfoModel.lName!}",
                        style: ubuntuBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color:
                                Theme.of(context).textTheme.bodySmall!.color),
                      ),
                    const SizedBox(
                      width: Dimensions.paddingSizeLarge,
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
                    isLoggedIn
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (userInfoModel.bookingsCount != null)
                                ColumnText(
                                  amount: userInfoModel.bookingsCount!,
                                  title: 'bookings'.tr,
                                ),
                            ],
                          )
                        : const SizedBox(height: Dimensions.paddingSizeSmall),
                  ],
                ),
              ),
              isLoggedIn
                  ? Positioned(
                      right: Dimensions.paddingSizeDefault,
                      top: Dimensions.paddingSizeSmall,
                      child: CustomButton(
                        width: ResponsiveHelper.isDesktop(context) ? 120 : 80,
                        fontSize: Dimensions.fontSizeSmall,
                        onPressed: () {
                          Get.toNamed(RouteHelper.profileEdit);
                        },
                        buttonText: 'edit_profile'.tr,
                      ))
                  : const SizedBox()
            ],
          ),
        ));
  }
}
