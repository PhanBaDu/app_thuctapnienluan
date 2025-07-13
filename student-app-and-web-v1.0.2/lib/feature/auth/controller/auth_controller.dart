import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/core/common_models/errrors_model.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/data/model/response/response_model.dart';
import 'package:get_lms_flutter/feature/auth/model/signup_body.dart';
import 'package:get_lms_flutter/feature/auth/model/social_log_in_body.dart';
import 'package:get_lms_flutter/feature/auth/repository/auth_repo.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
  }

  bool? _isLoading = false;
  bool? _notification = true;
  bool? _acceptTerms = false;
  bool? get isLoading => _isLoading;
  bool? get notification => _notification;
  bool? get acceptTerms => _acceptTerms;

  ///TextEditingController for signUp screen
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var countryDialCodeForSignup;

  ///textEditingController for signIn screen
  var signInPhoneController = TextEditingController();
  var signInPasswordController = TextEditingController();
  var countryDialCodeForSignIn;

  ///TextEditingController for forgot password
  var forgotEmailController = TextEditingController();
  var countryDialCode;
  String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;

  ///TextEditingController for new pass screen
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  ///form validation key

  @override
  void onInit() {
    super.onInit();
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    forgotEmailController.text = '';
    newPasswordController.text = '';
    _isLoading = false;
    confirmNewPasswordController.text = '';
    signInPhoneController.text = getUserNumber();
    signInPasswordController.text = getUserPassword();
    countryDialCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel.countryCode != null
                ? Get.find<SplashController>().configModel.countryCode!
                : "BD")
        .dialCode;
    countryDialCodeForSignup = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel.countryCode != null
                ? Get.find<SplashController>().configModel.countryCode!
                : "BD")
        .dialCode;
    countryDialCodeForSignIn = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel.countryCode != null
                ? Get.find<SplashController>().configModel.countryCode!
                : "BD")
        .dialCode;
  }

  onClose() {
    super.onClose();
  }

  fetchUserNamePassword() {
    signInPhoneController.text = getUserNumber();
    signInPasswordController.text = getUserPassword();
  }

  Future<void> registration() async {
    String numberWithCountryCode =
        countryDialCodeForSignup + phoneController.value.text;

    bool isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        final phoneNumber = PhoneNumber.parse(numberWithCountryCode);
        isValid = phoneNumber.isValid();
      } catch (e) {}
    }

    if (isValid) {
      SignUpBody signUpBody = SignUpBody(
          fName: firstNameController.value.text,
          lName: lastNameController.value.text,
          email: emailController.value.text,
          phone: numberWithCountryCode,
          password: passwordController.value.text,
          confirmPassword: confirmPasswordController.value.text);
      _isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        update();
      });
      Response? response = await authRepo.registration(signUpBody);
      if (response!.statusCode == 200) {
        if (response.body['status'] == 'success') {
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          phoneController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.main));
        }

        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text('registration_200'.tr),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ));
      } else {
        ErrorsModel _errorResponse = ErrorsModel.fromJson(response.body);
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
            '${_errorResponse.responseCode}_${_errorResponse.errors!.elementAt(0).errorCode!}'
                .tr,
            style: ubuntuRegular.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      }
      _isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        update();
      });
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text('phone_number_with_valid_country_code'.tr),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red));
    }
  }

  Future<void> login() async {
    String numberWithCountryCode = signInPhoneController.value.text;
    _isLoading = true;
    update();
    Response? response = await authRepo.login(
        phone: numberWithCountryCode,
        password: signInPasswordController.value.text);
    if (response!.statusCode == 200) {
      printLog(response.body['token']);
      authRepo.saveUserToken(response.body['token']);
      await authRepo.updateToken();
      _navigateLogin();
      Get.find<CartController>().getCartData().then((cartList) {
        if (cartList.isNotEmpty) {
          Get.find<CartController>()
              .addMultipleCartToServer()
              .then((value) {})
              .then((value) =>
                  Get.find<CartController>().getCartListFromServer());
        }
      });
    } else {
      customSnackBar(response.statusText!.tr);
    }
    _isLoading = false;
    update();
  }

  _navigateLogin() {
    Get.offAllNamed(RouteHelper.getInitialRoute());
    if (_isActiveRememberMe) {
      saveUserNumberAndPassword(signInPhoneController.value.text,
          signInPasswordController.value.text);
    } else {
      clearUserNumberAndPassword();
    }

    signInPhoneController.clear();
    signInPasswordController.clear();
  }

  Future<void> loginWithSocialMedia(SocialLogInBody socialLogInBody) async {
    _isLoading = true;
    update();
    printLog(socialLogInBody.toString());
    Response? response = await authRepo.loginWithSocialMedia(socialLogInBody);
    printLog(response!.body);
    if (response.statusCode == 200) {
      String _token = response.body['token'];
      if (_token.isNotEmpty) {
        authRepo.saveUserToken(response.body['token']);
        await authRepo.updateToken();
        Get.offAllNamed(RouteHelper.getInitialRoute());
      }
    } else {
      customSnackBar(response.statusText!);
    }
    _isLoading = false;
    update();
  }

  Future<void> forgetPassword() async {
    String _forgotEmail = forgotEmailController.value.text;
    _mobileNumber = _forgotEmail;
    _isLoading = true;
    update();
    Response? response = await authRepo.forgetPassword(_forgotEmail);
    printLog(response!.statusCode);
    if (response.body['status'] == 'success') {
      _isLoading = false;
      customSnackBar('successfully_sent_otp'.tr, isError: false);
      Get.toNamed(RouteHelper.getVerificationRoute(_forgotEmail));
    } else {
      _isLoading = false;
      customSnackBar('invalid_number'.tr);
    }
    update();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<void> verifyToken(String phoneOrEmail) async {
    Response? response =
        await authRepo.verifyToken(phoneOrEmail, _verificationCode);
    printLog(response!.body);
    if (response.body['status'] == 'success') {
      Navigator.popAndPushNamed(
          Get.context!,
          RouteHelper.getResetPasswordRoute(
              phoneOrEmail.substring(1, phoneOrEmail.length - 1),
              _verificationCode));
      customSnackBar('${response.body['message']}'.tr, isError: false);
    } else {
      customSnackBar('invalid_otp'.tr);
    }
    _isLoading = false;
    update();
  }

  Future<void> resetPassword(String phoneOrEmail) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(
        _mobileNumber,
        _otp,
        newPasswordController.value.text,
        confirmNewPasswordController.value.text);
    if (response!.body['status'] == 'success') {
      forgotEmailController.clear();
      newPasswordController.clear();
      confirmNewPasswordController.clear();
      Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
      customSnackBar('password_change_successfully'.tr, isError: false);
    } else {
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }

  Future<void> deleteAccount() async {
    _isLoading = true;
    update();
    Response? response = await authRepo.deleteAccount();
    printLog(response!.body);
    if (response.body['status'] == 'success') {
      customSnackBar('account_deleted_successfully'.tr, isError: false);
    } else {
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }

  String _verificationCode = '';
  String _otp = '';
  String get otp => _otp;
  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if (_verificationCode.isNotEmpty) {
      _otp = _verificationCode;
    }
    update();
  }

  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms!;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool? setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

  // TODO: Fix GoogleSignIn for new version
  // final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  // GoogleSignInAccount? googleAccount;
  // GoogleSignInAuthentication? auth;

  // Future<void> socialLogin() async {
  //   try {
  //     googleAccount = await _googleSignIn.signIn();
  //     if (googleAccount != null) {
  //       auth = await googleAccount!.authentication;
  //     }
  //     update();
  //   } catch (e) {
  //     print('Google Sign In Error: $e');
  //   }
  // }
}
