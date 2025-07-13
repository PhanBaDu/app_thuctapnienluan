import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/components/custom_text_field.dart';
import 'package:get_lms_flutter/core/helper/form_validation.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';


class NewPassScreen extends StatefulWidget {
  final String phoneOrEmail;
  final String otp;
  const NewPassScreen({Key? key,required this.phoneOrEmail, required this.otp}) : super(key: key);

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final GlobalKey<FormState> newPassKey = GlobalKey<FormState>();


  @override
  void initState() {
    Get.find<AuthController>().newPasswordController.clear();
    Get.find<AuthController>().confirmNewPasswordController.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();
    return Scaffold(
      appBar: CustomAppBar(title:'change_password'.tr, onBackPressed: (){
        Get.find<AuthController>().updateVerificationCode('');
        Get.back();
      },),
      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Center(child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: Form(
            key: newPassKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                      borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                    ),
                    child: CustomTextField(
                        title: 'new_password'.tr,
                        hintText: '**************',
                        controller: controller.newPasswordController,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        onValidate: (String? value){
                          return FormValidation().isValidPassword(value!);
                        }
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                      borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                    ),
                    child: CustomTextField(
                      title: 'confirm_new_password'.tr,
                      hintText: '**************',
                      controller: controller.confirmNewPasswordController,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      onValidate: (String? value){
                        return FormValidation().isValidPassword(value!);
                      },
                      onSubmit: (text) => GetPlatform.isWeb ? _resetPassword(controller.confirmNewPasswordController.text,controller.confirmNewPasswordController.text) : null,
                    ),
                  ),

                ]),
              ),
              const SizedBox(height: 30),

              GetBuilder<UserController>(builder: (userController) {
                return GetBuilder<AuthController>(builder: (authBuilder) {
                  if(authBuilder.isLoading! && userController.isLoading){
                    return  const Center(child: CircularProgressIndicator());
                  }else{
                    return CustomButton(
                      buttonText: 'change_password'.tr,
                      onPressed: () {
                        if(isRedundentClick(DateTime.now())){
                          return;
                        }
                        else{
                          _resetPassword(
                              controller.newPasswordController.value.text,
                              controller.confirmNewPasswordController.value.text);
                        }
                      },
                    );
                  }
                });
              }),

            ]),
          ),
        )),
      )))),
    );
  }

  void _resetPassword(newPassword, confirmNewPassword) {
    if(newPassKey.currentState!.validate()){
      printLog("$newPassword $confirmNewPassword");
      if(newPassword != confirmNewPassword){
        customSnackBar('password_not_matched'.tr);
      }else{
        Get.find<AuthController>().resetPassword(widget.phoneOrEmail);
      }
    }
  }
}




