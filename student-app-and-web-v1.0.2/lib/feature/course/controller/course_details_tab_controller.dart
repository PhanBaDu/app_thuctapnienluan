import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/course/repository/course_details_repo.dart';

enum ServiceTabControllerState {serviceOverview,faq,review}

class ServiceTabController extends GetxController with GetSingleTickerProviderStateMixin{
  final CourseDetailsRepo serviceDetailsRepo;
  ServiceTabController({required this.serviceDetailsRepo});

  List<Faqs>? faqs = [];


  List<Widget> serviceDetailsTabs(){
    printLog("faqs:$faqs");
    if(faqs!.length > 0){
      return  [
        Tab(text: 'service_overview'.tr),
        Tab(text: 'faqs'.tr),
        Tab(text: 'reviews'.tr),
      ];
    }
    return  [
      Tab(text: 'service_overview'.tr),
      Tab(text: 'reviews'.tr),
    ];
  }

  TabController? controller;
  var servicePageCurrentState = ServiceTabControllerState.serviceOverview;
  void updatePageState(ServiceTabControllerState serviceDetailsTabControllerState){
    servicePageCurrentState = serviceDetailsTabControllerState;
    update();
  }

  bool? _isLoading;
  int? _pageSize;
  bool get isLoading => _isLoading!;
  int? get pageSize => _pageSize!;
  String? _serviceID;
  int? _offset = 1;
  int? get offset => _offset;
  String? get serviceID => _serviceID;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length:faqs!.length > 0 ? 3 :2);
  }


  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}