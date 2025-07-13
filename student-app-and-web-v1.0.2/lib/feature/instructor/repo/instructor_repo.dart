import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class InstructorRepo {
  final ApiClient apiClient;
  InstructorRepo({required this.apiClient});

  Future<Response> getInstructorList(int offset) async {
    return await apiClient.getData(AppConstants.instructorUri);
  }


  Future<Response> createMeeting({required String instructorId, required String meetingDate, required String userID}) async {
    print(instructorId);
    print(userID);
    print(meetingDate);
    Map<String, String> body = {"instructor_id":  instructorId, "meeting_date": meetingDate, "user_id": userID};
    return await apiClient.postData(AppConstants.placeMeeting, body);
  }


}