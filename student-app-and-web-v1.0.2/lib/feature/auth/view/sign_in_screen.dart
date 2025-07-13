import 'dart:async';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_text_field.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/web_menu_bar.dart';
import 'package:get_lms_flutter/core/helper/form_validation.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/auth/widgets/social_login_widget.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
   const SignInScreen({Key? key,required this.exitFromApp}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

   bool _canExit = GetPlatform.isWeb ? true : false;

  final GlobalKey<FormState> customerSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr, style: const TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            ));
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        }else {
          return true;
        }
      },
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : !widget.exitFromApp ? AppBar( elevation: 0, backgroundColor: Colors.transparent) : null,
        body: SafeArea(child: Center(
          child: FooterBaseWidget(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Center(
                  child: Container(
                    width: context.width > 700 ? Dimensions.webMaxWidth: context.width,
                    padding: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
                    decoration: context.width > 700 ? BoxDecoration(
                      color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    ) : null,
                    child: GetBuilder<AuthController>(
                        initState:(state){
                          Get.find<AuthController>().fetchUserNamePassword();
                        },
                        builder: (authController) {
                      return Form(
                        key: customerSignInKey,
                        child: Column(children: [
                          Image.asset(
                            Images.logo,
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          Text('sign_in_welcome'.tr, style: ubuntuBold.copyWith(fontSize: 20,
                              color: Theme.of(context).primaryColor),),
                          const SizedBox(height: 30),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                            ),
                            child: CustomTextField(
                              title: 'email_phone'.tr,
                              hintText: 'enter_email_or_phone'.tr,
                              controller: authController.signInPhoneController,
                              focusNode: _phoneFocus,
                              isAutoFocus: true,
                              nextFocus: _passwordFocus,
                              capitalization: TextCapitalization.words,
                              onCountryChanged: (CountryCode countryCode) =>
                              authController.countryDialCodeForSignIn = countryCode.dialCode!,
                              onValidate: (String? value){
                                return (GetUtils.isPhoneNumber(value!) || GetUtils.isEmail(value)) ? null : 'enter_email_or_phone'.tr;
                              },
                            ),
                          ),

                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                            ),
                            child: CustomTextField(
                              title: 'password'.tr,
                              hintText: '************'.tr,
                              controller: authController.signInPasswordController,
                              focusNode: _passwordFocus,
                              inputType: TextInputType.visiblePassword,
                              isPassword: true,
                              inputAction: TextInputAction.done,
                              onValidate: (String? value){
                                return FormValidation().isValidPassword(value!);
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  onTap: () => authController.toggleRememberMe(),
                                  title: Row(
                                    children: [
                                      SizedBox(
                                        width: 20.0,
                                        child: Checkbox(
                                          activeColor: Theme.of(context).primaryColor,
                                          value: authController.isActiveRememberMe,
                                          onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                                      Text(
                                        'remember_me'.tr,
                                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  horizontalTitleGap: 0,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Get.toNamed(RouteHelper.getForgotPassRoute()),
                                  child: Text('forgot_password'.tr, style: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor,
                                  )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          !authController.isLoading! ? CustomButton(
                            buttonText: 'sign_in'.tr,
                            onPressed:  ()  {
                              if(customerSignInKey.currentState!.validate()) {
                                _login(authController);
                              }
                            },
                          ):
                          const Center(child: CircularProgressIndicator()),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${'do_not_have_an_account'.tr} ',
                                style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                ),
                              ),

                              TextButton(
                                onPressed: (){
                                  authController.signInPhoneController.clear();
                                  authController.signInPasswordController.clear();
                                  Get.toNamed(RouteHelper.getSignUpRoute());
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50,30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                                ),
                                child: Text('sign_up'.tr, style: ubuntuRegular.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeSmall,
                                )),
                              )
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          const SocialLoginWidget(),
                          const SizedBox(height: Dimensions.paddingSizeDefault,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'explore_as'.tr,
                                style: ubuntuMedium.copyWith(color:Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6)),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50,30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: (){
                                // Get.find<CartController>().getCartData();
                                Get.offNamed(RouteHelper.getInitialRoute());
                              }, child:  Text(
                                'guest'.tr,
                                style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor),
                              ),)

                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),

                        ]),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _login(AuthController authController) async {
    authController.login();
  }
}
