import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/model/response/notification_model.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/notification/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService{
  bool _isLoading = false;

  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  List<NotificationModel>? _notificationList;
  List<NotificationModel>? get notificationList => _notificationList;

  bool get isLoading => _isLoading;
  int _pageSize = 1;
  int _offset = 1;
  int get offset => _offset;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_offset < _pageSize) {
          getNotifications(_offset + 1, reload: false);
        }else{
          printLog("end of the page");
        }
      }
    });
  }


  Future<void> getNotifications(int offset, {bool reload = true})async{
    _offset = offset;
    if(reload){
      _notificationList = [];
    }
    _isLoading = true;
    Response response = await notificationRepo.getNotificationList(offset);
    if(response.statusCode == 200){
      _pageSize = response.body['data']['last_page'];
      response.body['data']['data'].forEach((notification){
        _notificationList!.add(NotificationModel.fromJson(notification));
      });

      _isLoading =false;
    } else{
      _isLoading =false;
      ApiValidator.validateApi(response);
    }
    update();
  }
}
