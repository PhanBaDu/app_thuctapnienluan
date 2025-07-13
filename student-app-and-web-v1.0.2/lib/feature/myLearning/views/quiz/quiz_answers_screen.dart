import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/myLearning/model/quiz_details_model.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/labeled_radio_button.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/quiz_list_line.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'quiz_start_page.dart';

class QuizAnswersScreen extends StatefulWidget {
  final List<GivenAnswer> givenAnswers;
  const QuizAnswersScreen({super.key, required this.givenAnswers});

  @override
  State<QuizAnswersScreen> createState() => _QuizAnswersScreenState();
}

class _QuizAnswersScreenState extends State<QuizAnswersScreen> {
  List<GivenAnswer> givenAnswerList = [];
  List<Questions> questionsList = [];
  List<bool> ansList = [];

  @override
  void initState() {
    super.initState();
    givenAnswerList.clear();
    questionsList.clear();
    ansList.clear();
    givenAnswerList = widget.givenAnswers;
    for (var ans in givenAnswerList) {
      questionsList.add(ans.question);
      ansList.add(ans.isCorrect);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'quiz_answer_screen'.tr,),
      body:  mainUI(context),
    );
  }

  Widget appBar(BuildContext context, QuizDetailsContent quiz) {
    return CustomAppBar(
      title: quiz.title??'',
      centerTitle: true,
    );
  }

  Widget mainUI(BuildContext context) {
    return FooterBaseWidget(child: SizedBox(
      width: Dimensions.webMaxWidth,
      child: Column(
        children: [
          ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: Column(
                  children: [
                    QuizListLine(
                      lineColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.06),
                      indicators: indicatorList(),
                      style: PaintingStyle.stroke,
                      children: questionListWidgets(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: CustomButton(
                        onPressed: () => Get.offAllNamed(RouteHelper.main),
                        buttonText: 'continue_course'.tr,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  bool isUserPassed(QuizDetailsContent quiz) {
    int passMark = questionsList.length ~/ 3;
    int totalMarks = questionsList.length;
    int totalQuestion = questionsList.length;
    double perQuestionMark = totalMarks / totalQuestion;
    double userObtainedMarks = 0;
    for (var ans in givenAnswerList) {
      if (ans.isCorrect) {
        userObtainedMarks = userObtainedMarks + perQuestionMark;
      }
    }
    return userObtainedMarks >= passMark;
  }

  double calculateTotalMarks(QuizDetailsContent quiz) {
    int totalMarks = 10 ?? 0;
    int totalQuestion = questionsList.length;
    double perQuestionMark = totalMarks / totalQuestion;
    double userObtainedMarks = 0;
    for (var ans in givenAnswerList) {
      if (ans.isCorrect) {
        userObtainedMarks = userObtainedMarks + perQuestionMark;
      }
    }
    return userObtainedMarks;
  }

  String resultText(QuizDetailsContent quiz) => isUserPassed(quiz)
      ? "Congratulation ! you have passed the quiz exam"
      : "Sorry, You have failed the quiz exam";

  Widget questionItemDefault(Questions question, int index) => SizedBox(
      width: 290,
      child: LabeledRadioButton(
        question: question,
        isCorrectAnsSelected: (bool value) {},
        isClickable: false,
        resultIndex: givenAnswerList[index].selectedIndexes[0],
        ans: ansList.elementAt(index),
      ));

  Widget textTitle({required String title, required TextStyle style}) {
    return Text(
      title,
      style: style,
    );
  }

  headerUI(QuizDetailsContent? quiz, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customContainer(
          title: '${formatTime(122)} mins',
          sunTitle: 'your_time'.tr,
          style: ubuntuMedium.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.w500,
          ),
          style2: ubuntuRegular.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color!,
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const SizedBox(
          width: Dimensions.paddingSizeSmall,
        ),
        customContainer(
          title: calculateTotalMarks(quiz!).toStringAsFixed(2),
          sunTitle: 'your_score'.tr,
          style: ubuntuMedium.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.w500,
          ),
          style2: ubuntuRegular.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color!,
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const SizedBox(
          width: Dimensions.paddingSizeSmall,
        ),
        customContainer(
          title: isUserPassed(quiz) ? "passed".tr : "failed".tr,
          sunTitle: 'your_result'.tr,
          style: ubuntuMedium.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.w500,
          ),
          style2: ubuntuRegular.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color!,
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
      ],
    );
  }

  Widget customContainer(
      {required String title,
        required String sunTitle,
        required TextStyle style,
        required TextStyle style2}) {
    return Container(
      width: 100,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Theme.of(context).cardColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(child: textTitle(title: title, style: style)),
            FittedBox(child: textTitle(title: sunTitle, style: style2)),
          ],
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  List<Widget> indicatorList() {
    //auto pass for short question widget
    // and check other question type
    return List.generate(
        ansList.length,
            (index) => indicatorItem(ansList[index]));
  }

  Widget indicatorItem(bool isCorrectAnswer) => isCorrectAnswer ? CircleAvatar(
    backgroundColor: Colors.green,
    child: Image.asset(
      Images.correctIcon,
      scale: 3,
      color: Theme.of(context).primaryColorLight,
    ),
  ) : CircleAvatar(
    backgroundColor: Colors.red,
    child: Image.asset(
      Images.inCorrectIcon,
      scale: 3,
      color: Theme.of(context).primaryColorLight,
    ),
  );

  List<Widget> questionListWidgets() => List.generate(
      questionsList.length,
          (index) => questionItemDefault(questionsList.elementAt(index), index));
}
