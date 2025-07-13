import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/quiz_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/model/quiz_details_model.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/labeled_radio_button.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'quiz_start_page.dart';

class QuizResultScreen extends StatefulWidget {
  final String quizID;
  final List<GivenAnswer> givenAnswer;
  final QuizDetailsContent quizDetailsContent;
  const QuizResultScreen({super.key, required this.quizID, required this.givenAnswer, required this.quizDetailsContent});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  List<Questions> questionsList = [];
  List<bool> ansList = [];
  int userObtainedMarks = 0;
  int incorrectMark = 0;

  @override
  void initState() {
    super.initState();
    questionsList.clear();
    ansList.clear();
    for (var ans in widget.givenAnswer) {
      questionsList.add(ans.question);
      ansList.add(ans.isCorrect);

      if (ans.isCorrect) {
        userObtainedMarks = userObtainedMarks + 1;
      }else{
        incorrectMark = incorrectMark + 1;
      }
    }
    Get.find<QuizController>().submitQuizResult(userObtainedMarks.toString(), questionsList.length.toString(), widget.quizID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:'quiz_details_screen'.tr,),
      body: FooterBaseWidget(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                Image.asset(Images.quizCongratulations,scale: 3,),
                Text(
                  resultText(widget.quizDetailsContent),
                  style: ubuntuRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color!,
                    fontSize: Dimensions.fontSizeOverLarge,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                quizMarkWidget(widget.quizDetailsContent),
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onPressed: (){
                      Get.toNamed(RouteHelper.getQuizAnswerPage(widget.givenAnswer));
                    },
                    buttonText: 'see_answers'.tr,),
                )
              ],
            ),
          ),
        )
      )
    );
  }


  bool isUserPassed(QuizDetailsContent quiz) {
    int passMark = questionsList.length ~/ 3;
    int totalMarks = questionsList.length;
    int totalQuestion = questionsList.length;
    double perQuestionMark = totalMarks / totalQuestion;
    double userObtainedMarks = 0;
    for (var ans in widget.givenAnswer) {
      if (ans.isCorrect) {
        userObtainedMarks = userObtainedMarks + perQuestionMark;
      }
    }
    return userObtainedMarks >= passMark;
  }

  Widget quizMarkWidget(QuizDetailsContent quiz) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        correctAndInCorrectWidget(Images.correctIcon, "${userObtainedMarks.toString()} Correct"),
        const SizedBox(width: Dimensions.paddingSizeDefault,),
        correctAndInCorrectWidget(Images.inCorrectIcon, "${incorrectMark.toString()} Incorrect")
      ],
    );
  }

  Widget correctAndInCorrectWidget(String imagePath, String title){
    return Row(
      children: [
        Image.asset(imagePath,scale: 3,),
        const SizedBox(width: Dimensions.paddingSizeMint,),
        Text(title),
      ],
    );
  }


  String resultText(QuizDetailsContent quiz) => isUserPassed(quiz)
      ? "Congratulations!"
      : "Sorry, You have failed the quiz exam";



  Widget questionItemDefault(Questions question, int index) => SizedBox(
      width: 290,
      child: LabeledRadioButton(
        question: question,
        isCorrectAnsSelected: (bool value) {},
        isClickable: false,
        resultIndex: widget.givenAnswer[index].selectedIndexes[0],
        ans: ansList.elementAt(index),
      ));

  Widget textTitle({required String title, required TextStyle style}) {
    return Text(
      title,
      style: style,
    );
  }
}
