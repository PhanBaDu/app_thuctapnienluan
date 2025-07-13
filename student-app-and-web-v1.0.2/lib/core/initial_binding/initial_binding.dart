import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/auth/repository/auth_repo.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/category/repository/category_repo.dart';
import 'package:get_lms_flutter/feature/coupon/controller/coupon_controller.dart';
import 'package:get_lms_flutter/feature/coupon/repo/coupon_repo.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/repository/course_repo.dart';
import 'package:get_lms_flutter/feature/courseResources/controller/course_resource_controller.dart';
import 'package:get_lms_flutter/feature/courseResources/repo/course_resource_repo.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/controller/enrolment_controller.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/repo/enrolment_repo.dart';
import 'package:get_lms_flutter/feature/instructor/controller/instructor_controller.dart';
import 'package:get_lms_flutter/feature/instructor/repo/instructor_repo.dart';
import 'package:get_lms_flutter/feature/language/controller/language_controller.dart';
import 'package:get_lms_flutter/feature/meetings/controller/meeting_controller.dart';
import 'package:get_lms_flutter/feature/meetings/repo/meeting_repo.dart';
import 'package:get_lms_flutter/feature/messenger/controller/messenger_controller.dart';
import 'package:get_lms_flutter/feature/messenger/repo/messenger_repo.dart';
import 'package:get_lms_flutter/feature/myCourse/controller/my_course_controller.dart';
import 'package:get_lms_flutter/feature/myCourse/repository/my_course_repo.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/assignment_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/my_learning_video_player_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/mylearning_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/quiz_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/repo/my_learning_repo.dart';
import 'package:get_lms_flutter/feature/myLearning/repo/quiz_repo.dart';
import 'package:get_lms_flutter/feature/notification/controller/notification_controller.dart';
import 'package:get_lms_flutter/feature/notification/repository/notification_repo.dart';
import 'package:get_lms_flutter/feature/pages/controller/webview_controller.dart';
import 'package:get_lms_flutter/feature/pages/repository/html_repo.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/feature/profile/repository/user_repo.dart';
import 'package:get_lms_flutter/feature/search/controller/search_controller.dart';
import 'package:get_lms_flutter/feature/search/repository/search_repo.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/feature/splash/repository/splash_repo.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    //common controller
    Get.lazyPut(() => SplashController(splashRepo: SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AuthController(authRepo: AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => NotificationController( notificationRepo: NotificationRepo(apiClient:Get.find() , sharedPreferences: Get.find())));
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => InstructorController(instructorRepo: InstructorRepo(apiClient: Get.find())));
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => CouponController(couponRepo: CouponRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => MeetingController(meetingRepo: MeetingRepo(apiClient: Get.find(), sharedPreferences: Get.find()),));
    Get.lazyPut(() => SearchController(searchRepo: SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => CourseController(serviceRepo: CourseRepo(apiClient: Get.find())));
    Get.lazyPut(() => MyCourseController(myCourseRepo: MyCourseRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
    Get.lazyPut(() => MyVideoPlayerController());
    Get.lazyPut(() => QuizController( quizRepo: QuizRepository(apiClient: Get.find(),)));
    Get.lazyPut(() => AssignmentController( myLearningRepo: MyLearningRepo(apiClient: Get.find(), sharedPreferences: Get.find(),)));
    Get.lazyPut(() => EnrolmentController( enrolmentRepo: EnrolmentRepo(apiClient: Get.find(), sharedPreferences: Get.find(),)));
    Get.lazyPut(() => MyLearningController(myLearningRepo: MyLearningRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => CourseResourceController(courseResourceRepo: CourseResourceRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => MessengerController(conversationRepo: MessengerRepo(apiClient: Get.find())));
  }
}