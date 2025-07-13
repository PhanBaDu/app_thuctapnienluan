import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/auth/model/social_log_in_body.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
          child: Text('or_continue_with'.tr,
              style: ubuntuRegular.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                  fontSize: Dimensions.fontSizeSmall))),
      const SizedBox(height: Dimensions.paddingSizeDefault),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
          onTap: () async {
            // await Get.find<AuthController>().socialLogin();
            // String id = '', token = '', email = '', medium ='';
            // if(Get.find<AuthController>().googleAccount != null){
            //   id = Get.find<AuthController>().googleAccount!.id;
            //   email = Get.find<AuthController>().googleAccount!.email;
            //   token = Get.find<AuthController>().auth!.accessToken!;
            //   medium = 'google';
            //   printLog('eemail =>$email token =>$token');
            // }
            // Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
            //   email: email, token: token, uniqueId: id, medium: medium,
            // ));
          },
          child: Image.asset(Images.google, height: 40, width: 40),
        ),
        const SizedBox(
          width: Dimensions.paddingSizeDefault,
        ),
        InkWell(
          onTap: () async {
            LoginResult result = await FacebookAuth.instance.login();
            if (result.status == LoginStatus.success) {
              Map userData = await FacebookAuth.instance.getUserData();
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: userData['email'],
                token: result.accessToken!.token,
                uniqueId: result.accessToken!.userId,
                medium: 'facebook',
              ));
            }
          },
          child: Image.asset(Images.facebook, height: 40, width: 40),
        ),
        const SizedBox(
          width: Dimensions.paddingSizeDefault,
        ),
        /*InkWell(
          onTap: () async{
            Get.find<AuthController>().loginWithSocialMedia('apple');
          },
          child: Image.asset(Images.apple, height: 40, width: 40),
        ),*/
      ]),
    ]);
  }
}
