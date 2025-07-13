import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/myLearning/model/lastViewedCourse_model.dart';
import 'package:get_lms_flutter/feature/myLearning/model/mylearning_model.dart';
import 'package:get_lms_flutter/feature/myLearning/repo/my_learning_repo.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';



enum MyLearningControllerState {lectures, courseOverview}

class MyLearningController extends GetxController with GetSingleTickerProviderStateMixin implements GetxService{

  final MyLearningRepo myLearningRepo;
  MyLearningController({required this.myLearningRepo});

  bool _isLoading = false;
  List<Sections>? _sections = [];
  List<Sections>? get sections => _sections;
  bool get isLoading => _isLoading;
  int _offset = 1;
  int? get offset => _offset;

  LastViewedCourseContent? _lastViewedCourseContent;
  LastViewedCourseContent? get lastViewedCourseContent => _lastViewedCourseContent;



  final ScrollController myCourseScreenScrollController = ScrollController();

  String? _certificateDownloadLink;
  String? get certificateDownloadLink => _certificateDownloadLink;

  bool _lastViewedCourseCalled = false;
  bool get lastViewedCourseCalled => _lastViewedCourseCalled;

  bool _lessonMarkAsCompleteCalled = false;
  bool get lessonMarkAsCompleteCalled => _lessonMarkAsCompleteCalled;



  List<Widget> serviceDetailsTabs(){

    return  [
      Tab(text: 'lectures'.tr),
      Tab(text: 'more'.tr),
    ];
  }

  TabController? controller;

  var currentState = MyLearningControllerState.lectures;
  void updatePageState(MyLearningControllerState serviceDetailsTabControllerState){
    currentState = serviceDetailsTabControllerState;
    update();
  }


  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 2);
    _lastViewedCourseCalled = false;
    _lessonMarkAsCompleteCalled = false;

  }


  Future<void> getMyLearningResource({required int offset, required bool isFromPagination, bool fromMenu= false, required int courseId})async{
    _isLoading = true;
    _offset = offset;
    if(!isFromPagination){
      _sections = null;
    }
    Response response = await myLearningRepo.getMyLearningResource(offset: offset,courseID: courseId);
    if(response.statusCode == 200){
      MyLearningContent myLearningContent = MyLearningContent.fromJson(response.body['data']);
      if(!isFromPagination){
        _sections = [];
      }
      for (var element in myLearningContent.sections!) {
        _sections!.add(element);
      }
    } else {
      ApiValidator.validateApi(response);
    }
    _isLoading = false;
    update();
  }


  Future<void> getLastViewedCourse()async{
    _isLoading = true;

    Response response = await myLearningRepo.getLastViewedCourse();
    if(response.statusCode == 200){
      _lastViewedCourseContent = LastViewedCourseContent.fromJson(response.body['data']);
      printLog("inside_getLastViewedCourse:$_lastViewedCourseContent");
    } else {
      ApiValidator.validateApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getCurrentViewedCourse({required String courseID, required String sectionIndex, required String lessonIndex})async{
    _lastViewedCourseContent = LastViewedCourseContent(
      id: int.parse(courseID),
      lastViewedCourse: int.parse(courseID),
      lastViewedSection: int.parse(sectionIndex),
      lastViewedLesson: int.parse(lessonIndex),
    );
    update();
  }




  Future<void> lessonMarkAsComplete({required String lessonID})async{
    print("inside_lessonMarkAsComplete");
    Response response = await myLearningRepo.lessonMarkAsComplete(lessonID);
    if(response.statusCode == 200){
      printLog("lesson_mark_as_complete");
      _lessonMarkAsCompleteCalled = true;
    } else {
      ApiValidator.validateApi(response);
    }
    update();
  }

  Future<void> lastViewedCourse({required String courseID, required String sectionIndex, required String lessonIndex})async{
    print("inside_last_viewed_course");
    Response response = await myLearningRepo.lastViewedLesson(courseID, sectionIndex, lessonIndex);
    if(response.statusCode == 200){
      _lastViewedCourseCalled = true;
    } else {
      ApiValidator.validateApi(response);
    }
    update();
  }


  Future<String> getCertificate({required String courseID})async{
    String certificateDownloadLink = '';
    Response response = await myLearningRepo.getCertificate(courseID: courseID);
    if(response.statusCode == 200){
      certificateDownloadLink = response.body['data']['file'];
    } else {
      certificateDownloadLink = '';
      ApiValidator.validateApi(response);
    }
    return certificateDownloadLink;
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }

}
