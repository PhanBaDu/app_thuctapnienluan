import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/initial_binding/initial_binding.dart';
import 'package:get_lms_flutter/feature/auth/view/sign_in_screen.dart';
import 'package:get_lms_flutter/feature/auth/view/sign_up_screen.dart';
import 'package:get_lms_flutter/feature/bottomNav/bottom_nav_screen.dart';
import 'package:get_lms_flutter/feature/cart/cart_screen.dart';
import 'package:get_lms_flutter/feature/category/bindings/category_bindings.dart';
import 'package:get_lms_flutter/feature/category/view/category_screen.dart';
import 'package:get_lms_flutter/feature/category/view/category_subcategory_screen.dart';
import 'package:get_lms_flutter/feature/category/view/sub_category_screen.dart';
import 'package:get_lms_flutter/feature/checkout/binding/checkout_binding.dart';
import 'package:get_lms_flutter/feature/checkout/view/checkout_screen.dart';
import 'package:get_lms_flutter/feature/checkout/view/order_successful_screen.dart';
import 'package:get_lms_flutter/feature/checkout/view/payment_screen.dart';
import 'package:get_lms_flutter/feature/coupon/view/coupon_screen.dart';
import 'package:get_lms_flutter/feature/course/bindings/course_bindings.dart';
import 'package:get_lms_flutter/feature/course/bindings/course_details_binding.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/course/view/all_course_view.dart';
import 'package:get_lms_flutter/feature/course/view/course_details_screen.dart';
import 'package:get_lms_flutter/feature/course/view/services_screen.dart';
import 'package:get_lms_flutter/feature/courseResources/view/course_resource_screen.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/view/enrolment_details_screen.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/view/enrolment_screen.dart';
import 'package:get_lms_flutter/feature/forgot/forget_pass_screen.dart';
import 'package:get_lms_flutter/feature/forgot/new_pass_screen.dart';
import 'package:get_lms_flutter/feature/forgot/verification_screen.dart';
import 'package:get_lms_flutter/feature/home/bindings/home_bindings.dart';
import 'package:get_lms_flutter/feature/instructor/model/instructor_model.dart';
import 'package:get_lms_flutter/feature/instructor/view/instructor_details_screen.dart';
import 'package:get_lms_flutter/feature/instructor/widgets/meeting_date_time_picker.dart';
import 'package:get_lms_flutter/feature/language/view/language_screen.dart';
import 'package:get_lms_flutter/feature/meetings/view/meeting_screen.dart';
import 'package:get_lms_flutter/feature/messenger/binding/chat_binding.dart';
import 'package:get_lms_flutter/feature/messenger/view/chat_details_screen.dart';
import 'package:get_lms_flutter/feature/messenger/view/chats_screen.dart';
import 'package:get_lms_flutter/feature/myCourse/view/my_course_screen.dart';
import 'package:get_lms_flutter/feature/myLearning/model/quiz_details_model.dart';
import 'package:get_lms_flutter/feature/myLearning/views/assignment_screen.dart';
import 'package:get_lms_flutter/feature/myLearning/views/my_learning_screen.dart';
import 'package:get_lms_flutter/feature/myLearning/views/quiz/quiz_answers_screen.dart';
import 'package:get_lms_flutter/feature/myLearning/views/quiz/quiz_result_screen.dart';
import 'package:get_lms_flutter/feature/myLearning/views/quiz/quiz_start_page.dart';
import 'package:get_lms_flutter/feature/notification/view/notification_screen.dart';
import 'package:get_lms_flutter/feature/onboarding/binding/binding.dart';
import 'package:get_lms_flutter/feature/onboarding/view/onboarding_screen.dart';
import 'package:get_lms_flutter/feature/pages/pages_screen.dart';
import 'package:get_lms_flutter/feature/profile/bindings/edit_profile_bindings.dart';
import 'package:get_lms_flutter/feature/profile/view/edit_profile_screen.dart';
import 'package:get_lms_flutter/feature/profile/view/profile_screen.dart';
import 'package:get_lms_flutter/feature/root/view/not_found_screen.dart';
import 'package:get_lms_flutter/feature/root/view/not_logged_in_screen.dart';
import 'package:get_lms_flutter/feature/root/view/update_screen.dart';
import 'package:get_lms_flutter/feature/search/widget/search_result_screen.dart';
import 'package:get_lms_flutter/feature/settings/bindings/settings_bindings.dart';
import 'package:get_lms_flutter/feature/settings/view/settings_screen.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/feature/splash/view/splash_screen.dart';
import 'package:get_lms_flutter/feature/support/support_screen.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/html_type.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String offers = '/offers';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String searchScreen = '/search';
  static const String courseDetails = '/courseDetails';
  static const String profile = '/profile';
  static const String profileEdit = '/profile-edit';
  static const String notification = '/notification';
  static const String orderSuccess = '/order-completed';
  static const String checkout = '/checkout';
  static const String orderTracking = '/track-order';
  static const String html = '/html';
  static const String categories = '/categories';
  static const String categoryProduct = '/category-product';
  static const String itemCampaign = '/item-campaign';
  static const String support = '/help-and-support';
  static const String rateReview = '/rate-and-review';
  static const String update = '/update';
  static const String cart = '/cart';
  static const String addAddress = '/add-address';
  static const String editAddress = '/edit-address';
  static const String restaurantReview = '/restaurant-review';
  static const String services = '/services';
  static const String serviceImages = '/service-images';
  static const String chatScreen = '/chat-screen';
  static const String chatInbox = '/chat-inbox';
  static const String onBoardScreen = '/onBoardScreen';
  static const String settingScreen = '/settingScreen';
  static const String languageScreen = '/language-screen';
  static const String voucherScreen = '/voucherScreen';
  static const String bookingDetailsScreen = '/bookingDetailsScreen';
  static const String rateReviewScreen = '/rateReviewScreen';
  static const String allServiceScreen = '/allServiceScreen';
  static const String subCategoryScreen = '/subCategoryScreen';
  static const String paymentPage = '/paymentPage';
  static const String invoice = '/invoice';
  static const String completeBooking = '/completeBooking';
  static const String bookingScreen = '/bookingScreen';
  static const String notLoggedScreen = '/notLoggedScreen';
  static const String instructorScreen = '/instructorScreen';
  static const String myLearningScreen = '/myLearningScreen';
  static const String quizResultScreen = '/quizResultScreen';
  static const String quizStartPage = '/quizStartPage';
  static const String quizAnswerPage = '/quizAnswerPage';
  static const String assignmentList = '/assignmentList';
  static const String enrolmentList = '/enrolmentList';
  static const String enrolmentDetails = '/enrolmentDetails';
  static const String couponList = '/couponList';
  static const String myCourseScreen = '/myCourseScreen';
  static const String certificate = '/certificate';
  static const String createMeetingScreen = '/createMeetingScreen';
  static const String meetingScreen = '/meetingScreen';
  static const String courseResourceScreen = '/courseResourceScreen';

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getOffersRoute(String page) => '$offers?page=$page';
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getSignUpRoute() => signUp;
  static String getVerificationRoute(String email) {
    String data = base64Url.encode(utf8.encode(jsonEncode(email)));
    return '$verification?email=$data';
  }

  static String getMainRoute(String page) => '$main?page=$page';
  static String getResetPasswordRoute(String phoneOrEmail, String otp) {
    String data = base64Url.encode(utf8.encode(jsonEncode(phoneOrEmail)));
    return '$resetPassword?phoneOrEmail=$data&otp=$otp';
  }

  static String getSearchResultRoute({String? queryText}) =>
      '$searchScreen?query=${queryText ?? ''}';
  static String getCourseDetailsRoute(String id) => '$courseDetails?id=$id';
  static String getProfileRoute(String? fromPage) =>
      '$profile?fromPage=$fromPage';
  static String getEditProfileRoute() => profileEdit;
  static String getNotificationRoute() => notification;

  static String getOrderSuccessRoute(String status) =>
      '$orderSuccess?status=$status';
  static String getCheckoutRoute(String page) => '$checkout?page=$page';
  static String getOrderTrackingRoute(int id) => '$orderTracking?id=$id';
  static String getHtmlRoute(String page) => '$html?page=$page';
  static String getCategoryRoute(String fromPage, String campaignID) =>
      '$categories?fromPage=$fromPage&campaignID=$campaignID';
  static String getCategoryProductRoute(String id, String name) {
    List<int> _encoded = utf8.encode(name);
    String _data = base64Encode(_encoded);
    return '$categoryProduct?id=$id&name=$_data';
  }

  static String getItemCampaignRoute() => itemCampaign;
  static String getSupportRoute() => '$support';
  static String getReviewRoute() => '$rateReview';
  static String getUpdateRoute(bool isUpdate) =>
      '$update?update=${isUpdate.toString()}';
  static String getCartRoute() => cart;
  static String getAddAddressRoute(bool fromCheckout) =>
      '$addAddress?page=${fromCheckout ? 'checkout' : 'address'}';
  static String getRestaurantReviewRoute(int restaurantID) =>
      '$restaurantReview?id=$restaurantID';

  static String getServicesRoute() => '$services';

  static String getItemImagesRoute(Course product) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(product.toJson())));
    return '$serviceImages?item=$_data';
  }

  static String getChatScreenRoute(
      String channelId, String name, String image, String date, String userId) {
    return '$chatScreen?chatID=$channelId&name=$name&image=$image&date=$date&userId=$userId';
  }

  static String getSettingRoute() => settingScreen;
  static String getBookingScreenRoute(bool isFromMenu) =>
      '$bookingScreen?isFromMenu=$isFromMenu';

  static String getInboxScreenRoute() => chatInbox;
  static String getVoucherRoute() => voucherScreen;
  static String getCertificate() => certificate;

  static String getBookingDetailsScreen(String bookingID) {
    return '$bookingDetailsScreen?bookingID=$bookingID';
  }

  static String getForgotPassRoute() => forgotPassword;
  static String allServiceScreenRoute(String fromPage) =>
      '$allServiceScreen?fromPage=$fromPage';
  static String subCategoryScreenRoute(String categoryName) =>
      '$subCategoryScreen?category_name=$categoryName';
  static String getPaymentScreen(String url) => '$paymentPage?url=$url';
  static String getInvoiceRoute(String bookingID) =>
      '$invoice?bookingID=$bookingID';
  static String getCompletedBooking() => completeBooking;
  static String getLanguageScreen(String fromPage) =>
      '$languageScreen?fromPage=$fromPage';
  static String getNotLoggedScreen(String fromPage) =>
      '$notLoggedScreen?fromPage=$fromPage';
  static String getInstructorScreen(Instructor instructor) {
    String _data =
        base64Url.encode(utf8.encode(jsonEncode(instructor.toJson())));
    return '$instructorScreen?data=$_data';
  }

  static String getQuizDetailsScreen(
      List<GivenAnswer> answerList, QuizDetailsContent quizDetailsContent) {
    String data = base64Url.encode(utf8.encode(jsonEncode(answerList)));
    String quizDetailContent =
        base64Url.encode(utf8.encode(jsonEncode(quizDetailsContent.toJson())));
    return '$quizResultScreen?data=$data&quizDetailContent=$quizDetailContent';
  }

  static String getMyLearningScreen(String courseID) =>
      '$myLearningScreen?course_id=$courseID';
  static String getQuizStartPage(String quizID) =>
      '$quizStartPage?quiz_id=$quizID';
  static String getQuizAnswerPage(List<GivenAnswer> answerList) {
    String data = base64Url.encode(utf8.encode(jsonEncode(answerList)));
    return '$quizAnswerPage?data=$data';
  }

  static String getAssignmentList(String courseID) =>
      '$assignmentList?course_id=$courseID';
  static String getEnrolmentList() => enrolmentList;
  static String getCouponList() => couponList;
  static String getEnrolmentDetails(String enrolmentID) =>
      '$enrolmentDetails?enrolment_id=$enrolmentID';
  static String getCreateMeetingScreen(String instructorID) =>
      '$createMeetingScreen?instructor_id=$instructorID';
  static String getMyCourseScreen() => myCourseScreen;
  static String getMeetingScreen() => meetingScreen;
  static String getCourseResourceScreen(String courseID) =>
      '$courseResourceScreen?course_id=$courseID';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        binding: BottomNavBinding(),
        page: () => getRoute(const BottomNavScreen(pageIndex: 0))),
    GetPage(
        name: splash,
        page: () => SplashScreen(
            orderID:
                Get.parameters['id'] == 'null' ? null : Get.parameters['id'])),
    GetPage(
        name: languageScreen,
        page: () => LanguageScreen(
              fromPage: Get.parameters['fromPage']!,
            )),
    GetPage(
        name: signIn,
        page: () => SignInScreen(
              exitFromApp: Get.parameters['page'] == signUp ||
                  Get.parameters['page'] == splash,
            )),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(
        name: verification,
        page: () {
          List<int> _decode =
              base64Decode(Get.parameters['email']!.replaceAll(' ', '+'));
          String data = utf8.decode(_decode);
          return VerificationScreen(
            number: data,
          );
        }),
    GetPage(
        binding: BottomNavBinding(),
        name: main,
        page: () => getRoute(BottomNavScreen(
              pageIndex: Get.parameters['page'] == 'home'
                  ? 0
                  : Get.parameters['page'] == 'favourite'
                      ? 1
                      : Get.parameters['page'] == 'cart'
                          ? 2
                          : Get.parameters['page'] == 'order'
                              ? 3
                              : Get.parameters['page'] == 'menu'
                                  ? 4
                                  : 0,
            ))),
    GetPage(
        name: forgotPassword,
        page: () {
          return const ForgetPassScreen();
        }),
    GetPage(
        name: resetPassword,
        page: () {
          List<int> _decode = base64Decode(
              Get.parameters['phoneOrEmail']!.replaceAll(' ', '+'));
          String _data = utf8.decode(_decode);
          return NewPassScreen(
            phoneOrEmail: _data,
            otp: Get.parameters['otp']!,
          );
        }),
    GetPage(
        name: searchScreen,
        page: () =>
            getRoute(SearchResultScreen(queryText: Get.parameters['query']))),
    GetPage(
        name: courseDetails,
        binding: ServiceDetailsBinding(),
        page: () {
          return getRoute(Get.arguments ??
              CourseDetailsScreen(courseID: Get.parameters['id']!));
        }),
    GetPage(
        name: profile,
        page: () =>
            getRoute(ProfileScreen(fromPage: Get.parameters['fromPage']!))),
    GetPage(
        binding: EditProfileBinding(),
        name: profileEdit,
        page: () => getRoute(const EditProfileScreen())),
    GetPage(
        name: notification, page: () => getRoute(const NotificationScreen())),
    GetPage(
        name: orderSuccess,
        page: () {
          printLog(Get.parameters['status']);
          return getRoute(OrderSuccessfulScreen(
            status: Get.parameters['status']!.contains('success') ? 1 : 0,
          ));
        }),
    GetPage(
        binding: CheckoutBinding(),
        name: checkout,
        page: () => getRoute(const CheckoutScreen())),
    GetPage(
        binding: InitialBinding(),
        name: html,
        page: () => PagesScreen(
              htmlType: Get.parameters['page'] == 'terms-and-condition'
                  ? HtmlType.TERMS_AND_CONDITION
                  : Get.parameters['page'] == 'privacy-policy'
                      ? HtmlType.PRIVACY_POLICY
                      : Get.parameters['page'] == 'cancellation_policy'
                          ? HtmlType.CANCELLATION_POLICY
                          : HtmlType.ABOUT_US,
            )),
    GetPage(
        name: categories,
        page: () => getRoute(CategoryScreen(
            fromPage: Get.parameters['fromPage']!,
            campaignID: Get.parameters['campaignID']!))),
    GetPage(
        binding: CategoryBindings(),
        name: categoryProduct,
        page: () {
          List<int> _decode =
              base64Decode(Get.parameters['name']!.replaceAll(' ', '+'));
          String _data = utf8.decode(_decode);
          return getRoute(CategorySubCategoryScreen(
              categoryID: Get.parameters['id']!, categoryName: _data));
        }),
    GetPage(name: support, page: () => getRoute(ContactUsPage())),
    GetPage(
        name: update,
        page: () => AppUpdateScreen(
            isUpdateAvailable: Get.parameters['update'] == 'true')),
    GetPage(name: cart, page: () => getRoute(const CartScreen(fromNav: false))),
    GetPage(
        name: rateReview,
        page: () => getRoute(Get.arguments ?? NotFoundScreen())),
    GetPage(name: services, page: () => getRoute(const ServicesScreen())),
    GetPage(
      binding: OnBoardBinding(),
      name: onBoardScreen,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: settingScreen,
      binding: SettingsBinding(),
      page: () => const SettingScreen(),
    ),
    GetPage(
      binding: ServiceBinding(),
      name: allServiceScreen,
      page: () => getRoute(AllCourseView(
        fromPage: Get.parameters['fromPage']!,
      )),
    ),
    GetPage(
      binding: ServiceBinding(),
      name: subCategoryScreen,
      page: () => SubCategoryScreen(
        categoryTitle: Get.parameters['category_name']!,
      ),
    ),
    GetPage(
        binding: CheckoutBinding(),
        name: paymentPage,
        page: () => PaymentScreen(
              url: Get.parameters['url']!,
            )),
    GetPage(
        name: notLoggedScreen,
        page: () => NotLoggedInScreen(fromPage: Get.parameters['fromPage']!)),
    GetPage(
        name: instructorScreen,
        page: () => InstructorScreen(
              instructor: Instructor.fromJson(jsonDecode(utf8.decode(base64Url
                  .decode(Get.parameters['data']!.replaceAll(' ', '+'))))),
            )),
    GetPage(
      name: myLearningScreen,
      page: () => MyLearningScreen(courseID: Get.parameters['course_id']!),
    ),
    GetPage(
        name: quizStartPage,
        page: () => QuizStartPage(
              quizId: Get.parameters['quiz_id']!,
            )),
    GetPage(
        name: quizResultScreen,
        page: () {
          List<dynamic> jsonList = jsonDecode(utf8.decode(
              base64Url.decode(Get.parameters['data']!.replaceAll(' ', '+'))));
          List<GivenAnswer> givenAnswers =
              jsonList.map((e) => GivenAnswer.fromJson(e)).toList();
          QuizDetailsContent quizDetailContent = QuizDetailsContent.fromJson(
              jsonDecode(utf8.decode(base64Url.decode(
                  Get.parameters['quizDetailContent']!.replaceAll(' ', '+')))));
          return QuizResultScreen(
            quizID: '1',
            givenAnswer: givenAnswers,
            quizDetailsContent: quizDetailContent,
          );
        }),
    GetPage(
        name: quizAnswerPage,
        page: () {
          List<dynamic> jsonList = jsonDecode(utf8.decode(
              base64Url.decode(Get.parameters['data']!.replaceAll(' ', '+'))));
          List<GivenAnswer> givenAnswers =
              jsonList.map((e) => GivenAnswer.fromJson(e)).toList();
          return QuizAnswersScreen(givenAnswers: givenAnswers);
        }),
    GetPage(
        name: assignmentList,
        page: () => AssignmentScreen(
              courseID: Get.parameters['course_id']!,
            )),
    GetPage(name: enrolmentList, page: () => const EnrolmentScreen()),
    GetPage(
        name: enrolmentDetails,
        page: () => EnrolmentDetailsScreen(
              enrolmentId: Get.parameters['enrolment_id']!,
            )),
    GetPage(name: couponList, page: () => const CouponScreen()),
    GetPage(name: myCourseScreen, page: () => const MyCourseScreen()),
    GetPage(
        name: chatInbox,
        binding: ChatBinding(),
        page: () => const ChatsScreen()),
    GetPage(
        name: chatScreen,
        page: () => getRoute(ChatDetailsScreen(
            chatID: Get.parameters['chatID']!,
            image: Get.parameters['image']!,
            name: Get.parameters['name']!,
            date: Get.parameters['date']!,
            userId: Get.parameters['userId']!)),
        binding: ChatBinding()),
    GetPage(
        name: createMeetingScreen,
        page: () => CreateMeetingScreen(
              instructorId: Get.parameters['instructor_id']!,
            )),
    GetPage(
        name: courseResourceScreen,
        page: () => CourseResourceScreen(
              courseID: Get.parameters['course_id']!,
            )),
    GetPage(name: meetingScreen, page: () => const MeetingScreen()),
  ];

  static getRoute(Widget navigateTo) {
    int minimumVersion = 0;
    if (GetPlatform.isAndroid) {
      String? minVer =
          Get.find<SplashController>().configModel.appMinimumVersionAndroid;
      minimumVersion = minVer != null ? int.tryParse(minVer) ?? 0 : 0;
    } else if (GetPlatform.isIOS) {
      String? minVer =
          Get.find<SplashController>().configModel.appMinimumVersionIos;
      minimumVersion = minVer != null ? int.tryParse(minVer) ?? 0 : 0;
    }
    return AppConstants.appVersion < minimumVersion
        ? const AppUpdateScreen(isUpdateAvailable: true)
        : navigateTo;
  }
}
