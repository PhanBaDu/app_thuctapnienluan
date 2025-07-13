import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/feature/myLearning/model/quiz_details_model.dart';
import 'package:get_lms_flutter/feature/myLearning/repo/quiz_repo.dart';


class QuizController extends GetxController implements GetxService {
  final QuizRepository quizRepo;
  QuizController({required this.quizRepo});

  bool _isDataLoading = false;
  bool get isDataLoading => _isDataLoading;
  QuizDetailsContent? _quizDetailsContent;
  QuizDetailsContent? get quizDetailsContent => _quizDetailsContent;

  Future<void> getQuizDetails(int quizId) async {
    _isDataLoading = true;
    final response = await quizRepo.getQuizDetails(quizId);
    if (response != null && response.statusCode == 200) {
      _quizDetailsContent = QuizDetailsModel.fromJson(response.body).quizDetailsContent;
    }
    _isDataLoading = false;
    update();
  }

  Future<void> submitQuizResult(String marks, String totalMarks, String quizID) async {
    final response = await quizRepo.submitQuizResult(marks: marks, totalMarks: totalMarks, quizId: quizID);
    if (response != null && response.statusCode == 200) {
      customSnackBar('quiz_submitted_successfully'.tr, isError:false);
    }
  }
}
