import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  final String? number;
  VerificationScreen({super.key, @required this.number});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _number;
  Timer? _timer;
  int? _seconds = 0;

  @override
  void initState() {
    super.initState();
    _number = widget.number;
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if(_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'otp_verification'.tr),
      body: SafeArea(child: Scrollbar(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault) ,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: GetBuilder<AuthController>(builder: (authController) {
            return Column(children: [
              const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),
              Image.asset(
                Images.logo,
                height: 100,
                width: 100,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'enter_the_verification_code'.tr,
                  style: ubuntuMedium.copyWith(
                      height: 1.5,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                      fontSize: Dimensions.fontSizeDefault),
                  children: [
                    TextSpan(
                      text: _number!.substring(1,_number!.length-1),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                child: PinCodeTextField(
                  length: 4,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 60,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                    inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    activeColor: Theme.of(context).primaryColor.withOpacity(0.4),
                    activeFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: authController.updateVerificationCode,
                  beforeTextPaste: (text) => true,
                ),
              ),
              authController.verificationCode.length == 4 ? !authController.isLoading! ? CustomButton(
                buttonText: 'verify'.tr,
                onPressed: () {
                  if(isRedundentClick(DateTime.now())){
                    return;
                  }
                  authController.verifyToken(_number!);
                },
              ) : const Center(child: CircularProgressIndicator()) : const SizedBox.shrink(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('did_not_receive_the_code'.tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),),
                    TextButton(
                      onPressed: (){
                        Get.find<AuthController>().forgetPassword();
                      },
                      child: Text('resend_it'.tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),),),
                  ]) ,
            ]);
          }),
        ),
      ))),
    );
  }
}
