import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_text_field.dart';
import 'package:get_lms_flutter/feature/profile/controller/edit_profile_controller.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class EditProfileAccountInfo extends StatelessWidget {
  EditProfileAccountInfo({Key? key}) : super(key: key);
  final GlobalKey<FormState> accountInfoKey = GlobalKey<FormState>();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (editProfileController){
        return Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: accountInfoKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      title: 'password'.tr,
                        hintText: '**************',
                        controller: editProfileController.passwordController,
                        focusNode: _passwordFocus,
                        nextFocus: _confirmPasswordFocus,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        onValidate: (String? value){
                          return  editProfileController.validatePassword(value!);
                        }
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      title: 'confirm_password'.tr,
                        hintText: '**************',
                        controller: editProfileController.confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        onValidate: (String? value){
                           return editProfileController.validatePassword(value!);
                        }
                    ),
                    SizedBox(height: context.height*0.16,),
                    CustomButton(buttonText: 'change_password'.tr,onPressed: (){
                      if(accountInfoKey.currentState!.validate()){
                        editProfileController.updateAccountInfo();
                      }},
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customRichText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(text: title, style: ubuntuRegular.copyWith(color: const Color(0xff2C3439))),
        TextSpan(text: ' *', style: ubuntuRegular.copyWith(color: Colors.red)),
      ])),
    );
  }
}
