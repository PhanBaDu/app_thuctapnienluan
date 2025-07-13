import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/custom_text_field.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/web_shadow_wrap.dart';
import 'package:get_lms_flutter/core/helper/form_validation.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/profile/controller/edit_profile_controller.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/widget/deactivate_account_dialog.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});


  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  CustomAppBar(
          title: 'edit_profile'.tr,
          centerTitle: true,
          bgColor: Theme.of(context).primaryColor,
          isBackButtonExist: true,
          actions: [
            TextButton(
                onPressed: (){
                  if (updateProfileKey.currentState!.validate()) {
                    Get.find<EditProfileController>().updateUserProfile();
                  }
                },
                child:Text('save'.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).cardColor),))
          ],
        ),
        body: GetBuilder<EditProfileController>(
          init: Get.find<EditProfileController>(),
          builder: (editProfileController){
            return editProfileController.isLoading! ?
            const Center(child: CircularProgressIndicator(),) :
            FooterBaseWidget(
              child: WebShadowWrap(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                  child: Column(
                    children: [
                      Form(
                        key: updateProfileKey,
                        child: Column(
                            children: [
                              SizedBox(height: Get.height / 8),
                              if(ResponsiveHelper.isDesktop(context))
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  CustomButton(
                                    width: 100,
                                    buttonText: 'save'.tr,
                                    onPressed: (){
                                      if (updateProfileKey.currentState!.validate()) {
                                        Get.find<EditProfileController>().updateUserProfile();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              _profileImageSection(
                                editProfileController,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                              if(ResponsiveHelper.isMobile(context))
                                _firstList(editProfileController),
                              if(ResponsiveHelper.isMobile(context))
                                _secondList(editProfileController),
                              if(!ResponsiveHelper.isMobile(context))
                                Row(children: [
                                  Expanded(
                                    child: _firstList(editProfileController),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeLarge,),
                                  Expanded(
                                    child: _secondList(editProfileController),
                                  ),
                                ]),

                            ]),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                      TextButton(
                          onPressed: (){
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context, builder: (context) => const DeactivateAccountDialog());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("delete_my_account".tr),
                              const Icon(Icons.keyboard_arrow_right)
                            ],
                          ) ),
                      const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),
                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }

  Widget _profileImageSection(editProfileController) {
    return Container(
      height: 120,
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(Get.context!)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(.2),
                    width: 1),
              ),
              child: ClipOval(
                child: editProfileController.pickedProfileImageFile == null
                    ? CustomImage(
                  placeholder: Images.placeholder,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  image: '${AppConstants.baseUrl}${Get.find<UserController>().userInfoModel.image}',

                )
                    : kIsWeb
                    ? Image.network(editProfileController.pickedProfileImageFile!.path,
                    height: 100.0, width: 100.0, fit: BoxFit.cover)
                    : Image.file(
                    File(editProfileController.pickedProfileImageFile!.path)),
              ),
            ),
            InkWell(
              child: Icon(
                Icons.camera_enhance_rounded,
                color: Theme.of(Get.context!).cardColor,
              ),
              onTap: () => editProfileController.pickProfileImage(),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _firstList(EditProfileController editProfileController) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: CustomTextField(
            title: 'first_name'.tr,
            hintText: 'first_name'.tr,
            controller: editProfileController.firstNameController,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
            onValidate: (String? value) {
              return FormValidation().isValidLength(value!);
            }),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: CustomTextField(
            title: 'last_name'.tr,
            hintText: 'last_name'.tr,
            controller: editProfileController.lastNameController,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
            onValidate: (String? value) {
              return FormValidation().isValidLength(value!);
            }),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

   
      Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: CustomTextField(
            title: 'last_name'.tr,
            hintText: 'last_name'.tr,
            inputType: TextInputType.name,
            isEnabled: false,
            controller: editProfileController.emailController,
            capitalization: TextCapitalization.words,
            ),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),
    ],);
  }

  Widget _secondList(editProfileController) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: CustomTextField(
          hintText: 'enter_phone_number'.tr,
          controller: editProfileController.phoneController,
          inputType: TextInputType.phone,
          onValidate: (String? value){
            return GetUtils.isPhoneNumber(value!) ? null:'enter_phone_number'.tr;
          },
        ),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: CustomTextField(
          title: 'password'.tr,
          hintText: '****************'.tr,
          controller: editProfileController.passwordController,
          inputType: TextInputType.visiblePassword,
          onValidate: (String? value) {
            return FormValidation().isValidPassword(value!);
          },
          isPassword: true,
        ),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: CustomTextField(
          title: 'confirm_password'.tr,
          hintText: '****************'.tr,
          controller: editProfileController.confirmPasswordController,
          inputAction: TextInputAction.done,
          inputType: TextInputType.visiblePassword,
          isPassword: true,
          onValidate: (String? value) {
            return FormValidation().isValidPassword(value!);
          },
        ),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),
    ],);
  }

}


