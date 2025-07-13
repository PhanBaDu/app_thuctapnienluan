import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/myCourse/repository/my_course_repo.dart';

class MyCourseController extends GetxController implements GetxService{

  final MyCourseRepo myCourseRepo;
  MyCourseController({required this.myCourseRepo});


  bool _isLoading = false;
  List<Course>? _myCourseList = [];
  List<Course>? get myCourses => _myCourseList;
  bool get isLoading => _isLoading;
  int _offset = 1;
  int? get offset => _offset;
  final ScrollController myCourseScreenScrollController = ScrollController();
  int _bookingListPageSize = 0;
  int get bookingListPageSize=> _bookingListPageSize;
  

  @override
  void onInit() {
    super.onInit();
    myCourseScreenScrollController.addListener(() {
      if(myCourseScreenScrollController.position.pixels == myCourseScreenScrollController.position.maxScrollExtent) {
        if(offset! < bookingListPageSize){
          getMyCourseList(offset: offset! + 1,isFromPagination:true);
        }
      }
    });
  }


  Future<void> getMyCourseList({required int offset, required bool isFromPagination, bool fromMenu= false})async{
    _isLoading = true;
    _offset = offset;
    if(!isFromPagination){
      _myCourseList = null;
    }
    Response response = await myCourseRepo.getMyCourseList(offset: offset);
    if(response.statusCode == 200){
      printLog(response.body);
      CourseModel courseModel = CourseModel.fromJson(response.body);
      if(!isFromPagination){
        _myCourseList = [];
      }
      for (var element in courseModel.content!.serviceList!) {
        _myCourseList!.add(element);
      }
    } else {
      ApiValidator.validateApi(response);
    }
    _isLoading = false;
    update();
  }

}
