import 'dart:io';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class MessengerRepo {

  final ApiClient apiClient;
  MessengerRepo({required this.apiClient});

  Future<Response> getChannelList(int offset) async {
    return await apiClient.getData(AppConstants.getMessageList);
  }

  Future<Response> getChannelListBasedOnReferenceId(int offset,String referenceID) async {
    return await apiClient.getData('${AppConstants.getMessageList}offset=$offset&reference_id=$referenceID&reference_type=booking_id');
  }

  Future<Response> getConversation(String channelID,int offset) async {
    return await apiClient.getData('${AppConstants.getConversation}/$channelID');
  }

  Future<Response> sendInitialMessage(String userID,String content) async {
    return await apiClient.postData(AppConstants.sendInitialMessage, {"receiver_id": userID,"content":content,});
  }

}