import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/code_picker_widget.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_text_field.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/web_menu_bar.dart';
import 'package:get_lms_flutter/core/helper/form_validation.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/auth/widgets/condition_check_box.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final GlobalKey<FormState> customerSignUpKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.find<AuthController>().firstNameController.clear();
    Get.find<AuthController>().lastNameController.clear();
    Get.find<AuthController>().emailController.clear();
    Get.find<AuthController>().phoneController.clear();
    Get.find<AuthController>().passwordController.clear();
    Get.find<AuthController>().confirmPasswordController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
        body: GetBuilder<AuthController>(
          init: Get.find<AuthController>(),
          builder: (authController) {
            return authController.isLoading!
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : FooterBaseWidget(
                    child: SizedBox(
                      width: Dimensions.webMaxWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraLarge),
                        child: Column(
                          children: [
                            Form(
                              key: customerSignUpKey,
                              child: Column(children: [
                                SizedBox(height: Get.height / 8),
                                Image.asset(
                                  Images.logo,
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge),
                                Text(
                                  AppConstants.appName,
                                  style: ubuntuBold.copyWith(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                const SizedBox(
                                    height:
                                        Dimensions.paddingSizeExtraMoreLarge),
                                if (ResponsiveHelper.isMobile(context))
                                  _firstList(authController),
                                if (ResponsiveHelper.isMobile(context))
                                  _secondList(authController),
                                if (!ResponsiveHelper.isMobile(context))
                                  Row(children: [
                                    Expanded(
                                      child: _firstList(authController),
                                    ),
                                    const SizedBox(
                                      width: Dimensions.paddingSizeLarge,
                                    ),
                                    Expanded(
                                      child: _secondList(authController),
                                    ),
                                  ]),
                              ]),
                            ),
                            const ConditionCheckBox(),
                            const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge),
                            !authController.isLoading!
                                ? CustomButton(
                                    buttonText: 'sign_up'.tr,
                                    onPressed: authController.acceptTerms!
                                        ? () => _register(authController)
                                        : null,
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                            const SizedBox(
                              height: Dimensions.paddingSizeLarge,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${'already_have_an_account'.tr} ',
                                  style: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getSignInRoute(
                                        RouteHelper.main));
                                  },
                                  child: Text('let_us_sign_in'.tr,
                                      style: ubuntuRegular.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeDefault,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeLarge,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'explore_as'.tr,
                                  style: ubuntuMedium.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(.6)),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.offNamed(RouteHelper.getInitialRoute());
                                  },
                                  child: Text(
                                    'guest'.tr,
                                    style: ubuntuMedium.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeExtraMoreLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ));
  }

  Widget _firstList(AuthController authController) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.5)),
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          child: CustomTextField(
            title: 'first_name'.tr,
            hintText: 'enter_first_name'.tr,
            controller: authController.firstNameController,
            isAutoFocus: true,
            focusNode: _firstNameFocus,
            nextFocus: _lastNameFocus,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
            onValidate: (String? value) {
              return FormValidation().isValidFirstName(value!);
            },
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.5)),
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          child: CustomTextField(
            title: 'last_name'.tr,
            hintText: 'enter_last_name'.tr,
            controller: authController.lastNameController,
            focusNode: _lastNameFocus,
            nextFocus: _emailFocus,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
            onValidate: (String? value) {
              return FormValidation().isValidLastName(value!);
            },
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.5)),
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          child: CustomTextField(
            title: 'email_address'.tr,
            hintText: 'enter_email_address'.tr,
            controller: authController.emailController,
            focusNode: _emailFocus,
            nextFocus: _phoneFocus,
            inputType: TextInputType.emailAddress,
            onValidate: (String? value) {
              return GetUtils.isEmail(value!)
                  ? null
                  : 'enter_valid_email_address'.tr;
            },
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ],
    );
  }

  Widget _secondList(AuthController authController) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.5)),
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              CodePickerWidget(
                onChanged: (CountryCode countryCode) {
                  authController.countryDialCodeForSignup =
                      countryCode.dialCode!;
                  authController.update();
                },
                initialSelection: authController.countryDialCodeForSignup,
                favorite: [authController.countryDialCodeForSignup],
                showDropDownButton: true,
                padding: EdgeInsets.zero,
                showFlagMain: true,
                dialogBackgroundColor: Theme.of(context).cardColor,
                textStyle: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              Expanded(
                child: CustomTextField(
                  hintText: 'enter_phone_number'.tr,
                  controller: authController.phoneController,
                  focusNode: _phoneFocus,
                  nextFocus: _passwordFocus,
                  inputType: TextInputType.phone,
                  countryDialCode: authController.countryDialCodeForSignup,
                  onValidate: (String? value) {
                    return GetUtils.isPhoneNumber(value!)
                        ? null
                        : 'enter_phone_number'.tr;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.5)),
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          child: CustomTextField(
            title: 'password'.tr,
            hintText: '****************'.tr,
            controller: authController.passwordController,
            focusNode: _passwordFocus,
            nextFocus: _confirmPasswordFocus,
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
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.5)),
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          child: CustomTextField(
            title: 'confirm_password'.tr,
            hintText: '****************'.tr,
            controller: authController.confirmPasswordController,
            focusNode: _confirmPasswordFocus,
            inputAction: TextInputAction.done,
            inputType: TextInputType.visiblePassword,
            isPassword: true,
            onValidate: (String? value) {
              return FormValidation().isValidPassword(value!);
            },
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ],
    );
  }

  void _register(AuthController authController) async {
    if (customerSignUpKey.currentState!.validate()) {
      if (authController.passwordController.value.text !=
          authController.confirmPasswordController.value.text) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text('password_and_confirm_does_not_match'.tr),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
      } else {
        authController.registration();
      }
    }
  }
}
