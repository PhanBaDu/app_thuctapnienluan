import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/code_picker_widget.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/components/custom_text_field.dart';
import 'package:get_lms_flutter/core/helper/form_validation.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  @override
  void initState() {
    Get.find<AuthController>().forgotEmailController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:'forgot_password'.tr),
      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Center(child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: GetBuilder<AuthController>(
            builder: (authController){
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(Images.forgotPass,width: 100,height: 100,),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                  ),
                  child: CustomTextField(
                    title: 'email_address'.tr,
                    hintText: 'enter_email_address'.tr,
                    controller: authController.forgotEmailController,
                    inputType: TextInputType.emailAddress,
                    onValidate: (String? value){
                      return GetUtils.isEmail(value!) ? null:'enter_valid_email_address'.tr;
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),

                GetBuilder<AuthController>(builder: (authController) {
                  return !authController.isLoading! ? CustomButton(
                    buttonText: 'send_otp'.tr,
                    onPressed: () => _forgetPass(),
                  ) : const Center(child: CircularProgressIndicator());
                }),
              ]);
            },
          ),
        )),
      )))),
    );
  }

  void _forgetPass() async {

    if(Get.find<AuthController>().forgotEmailController.value.text.isNotEmpty){
      Get.find<AuthController>().forgetPassword();
    }else{
      customSnackBar('enter_phone_number'.tr);
    }

  }
}

