import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/instructor/model/instructor_model.dart';
import 'package:get_lms_flutter/feature/instructor/repo/instructor_repo.dart';

class InstructorController extends GetxController implements GetxService {
  final InstructorRepo instructorRepo;
  InstructorController({required this.instructorRepo});

  List<Instructor>? _instructorList;

  bool _isLoading = false;
  int? _pageSize;
  String? _type = 'all';
  String? _searchText = '';
  int? _offset = 1;

  List<Instructor>? get instructorList => _instructorList;
  bool get isLoading => _isLoading;
  int? get pageSize => _pageSize;
  String? get type => _type;
  String? get searchText => _searchText;
  int? get offset => _offset;


  final ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<InstructorController>().pageSize!;
        if (Get.find<InstructorController>().offset! < pageSize) {
          Get.find<InstructorController>().showBottomLoader();
          getInstructorList(Get.find<InstructorController>().offset!+1, false);
        }
      }
    });
  }

  Future<void> getInstructorList(int offset, bool reload ) async {
    _offset = offset;
    if(_instructorList == null || reload){
      Response response = await instructorRepo.getInstructorList(offset);
      if (response.statusCode == 200) {
        _instructorList = [];
        response.body['data']['data'].forEach((category) {
          _instructorList!.add(Instructor.fromJson(category));
        });
        _pageSize = 2;
        _pageSize = response.body['data']['last_page'];
      } else {
        ApiValidator.validateApi(response);
      }
      _isLoading = false;
      update();
    }
  }


  Future<void> createMeeting({required String instructorId, required String userId, required String meetingDate, }) async {
    update();
    Response response = await instructorRepo.createMeeting(instructorId: instructorId, userID: userId, meetingDate: meetingDate);
    if (response.body['status'] == 'success') {
      Get.back();
      customSnackBar('${response.body['message']}', isError: false);
    }else{
      customSnackBar('${response.body['response_code']}'.tr, isError: false);
    }
  }

  
  void showBottomLoader() {
    _isLoading = true;
    update();
  }

}
