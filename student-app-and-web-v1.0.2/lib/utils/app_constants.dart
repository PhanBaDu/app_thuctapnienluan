import 'package:get_lms_flutter/data/model/response/language_model.dart';

import 'images.dart';

class AppConstants {
  static const String appName = 'Get Learn';
  static const double appVersion = 1.0;
  static const String baseUrl = 'http://chien3008.zapto.org';
  static const String categoryUri = '/api/course-category';
  static const String instructorUri = '/api/instructor';
  static const String bannerUrl = '/api/promotional-banner?limit=10&offset=1';
  static const String allCourseUrl = '/api/course';
  static const String popularCourseUri = '/api/course?featured=1';
  static const String instructorBasedCourseUri = '/api/course?instructor_id=';
  static const String courseBasedOnSubCategory = '/api/course?sub_category_id=';
  static const String courseBasedOnCategory = '/api/course?category_id=';
  static const String courseDetailsUri = '/api/course/details';
  static const String subCategoryUrl = '/api/course-category?sub_category=';
  static const String configUrl = '/api/cofigurations';
  static const String forgotPasswordUrl = '/api/auth/student/forget-passord';
  static const String verifyTokenUrl = '/api/auth/student/verify-token';
  static const String resetPasswordUrl = '/api/student/reset-password';
  static const String registerUrl = '/api/auth/student/register';
  static const String loginUrl = '/api/auth/student/login';
  static const String deleteAccount = '/api/auth/student/profile';
  static const String addToCart = '/api/student/cart';
  static const String createEnrolment = '/api/student/enrollment';
  static const String getCartList = '/api/student/cart?limit=100&offset=1';
  static const String deleteCartItem = '/api/student/cart/';
  static const String deleteAllCart = '/api/student/cart/all';
  static const String quizDetails = '/api/student/quiz/';
  static const String firebaseToken = '/api/student/firebase-token';
  static const String myCourseUrl = '/api/student/course';
  static const String learningResource = '/api/student/course/class-room/';
  static const String assignmentList = '/api/student/assignment?course_id=';
  static const String lessonMarkAsComplete = '/api/student/lesson/';
  static const String lastViewedCourse = '/api/student/course/last-viewed';
  static const String certificate = '/api/student/course/certificate/';
  static const String enrolmentList = '/api/student/enrollment';
  static const String enrolmentDetails = '/api/student/enrollment/';
  static const String couponList = '/api/promotional-discount';
  static const String meetingList = '/api/student/meeting';
  static const String lessonResource = '/api/student/lesson-resource/';
  static const String studentInfoUrl = '/api/user';
  static const String applyCoupon = '/api/student/cart/apply-coupon';
  static const String notificationUrl = '/api/push-notification';
  static const String updateProfileUrl = '/api/student/profile';
  static const String submitAssignment = '/api/student/assignment/';
  static const String placeMeeting = '/api/place-meeeting';
  static const String searchUrl = '/api/course';
  static const String socialLoginUrl = '/api/auth/social/login';

  ///create channel , get channel , get conversation and send message
  static const String sendInitialMessage = '/api/instructor/conversation';
  static const String getMessageList = '/api/student/conversation';
  static const String getConversation = '/api/student/conversation';
  static const String pages = '/api/cofigurations/pages';

  // Shared Key
  static const String theme = 'get_lms_theme';
  static const String token = 'get_lms_token';
  static const String currencyCode = 'get_lms_country_code';
  static const String languageCode = 'get_lms_language_code';
  static const String cartList = 'get_lms_cart_list';
  static const String userPassword = 'get_lms_user_password';
  static const String userCurrencyCode = 'get_lms_user_country_code';
  static const String notification = 'get_lms_notification';
  static const String searchHistory = 'get_lms_search_history';
  static const String userNumber = 'get_lms_user_number';
  static const String notificationCount = 'get_lms_notification_count';
  static const String isSplashSeen = 'get_lms_splash_seen';
  static const String topic = 'students';
  static const String localizationKey = 'X-localization';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.us,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabicTwo,
        languageName: 'عربى',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
