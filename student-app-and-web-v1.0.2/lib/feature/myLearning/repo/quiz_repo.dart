import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';



class QuizRepository {
  final ApiClient apiClient;
  QuizRepository({required this.apiClient});

  Future<Response?> getQuizDetails(int quizId) async {
    return apiClient.getData("${AppConstants.quizDetails}$quizId");
  }

  Future<Response?> submitQuizResult({required String marks, required String totalMarks, required String quizId}) async {
    printLog('marks:$marks');
    printLog('total_marks:$totalMarks');
    Map<String, String> body = {};
    body.addAll(<String, String>{
    '_method': 'put',
     'marks': marks,
     'total_marks': totalMarks
    });

    return apiClient.postData("${AppConstants.quizDetails}$quizId", body);
  }
}
