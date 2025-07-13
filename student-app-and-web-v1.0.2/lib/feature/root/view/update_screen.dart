import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateScreen extends StatelessWidget {
  final bool? isUpdateAvailable;

  const AppUpdateScreen({super.key, required this.isUpdateAvailable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              isUpdateAvailable! ? Images.update : Images.maintenance,
              scale: 2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              isUpdateAvailable! ? 'update'.tr : 'we_are_under_maintenance'.tr,
              style: ubuntuBold.copyWith(fontSize: MediaQuery.of(context).size.height * 0.023, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              isUpdateAvailable! ? 'update_is_required'.tr : 'we_are_under_maintenance'.tr,
              style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.height * 0.0175, color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isUpdateAvailable! ? MediaQuery.of(context).size.height * 0.04 : 0),
            isUpdateAvailable! ? CustomButton(
                buttonText: 'update'.tr, onPressed: () async {
              String appUrl = 'https://google.com';
              if (GetPlatform.isAndroid) {
                appUrl = Get.find<SplashController>().configModel.appUrlAndroid!;
              } else if (GetPlatform.isIOS) {
                appUrl = Get.find<SplashController>().configModel.appUrlIos!;
              }
              _launchUrl(Uri.parse(appUrl));
              if (await launchUrl(Uri.parse(appUrl))) {
                launchUrl(Uri.parse(appUrl));
              } else {
                customSnackBar('${'can_not_launch'.tr} $appUrl');
              }
            }) : const SizedBox(),
          ]),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}