import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/quiz_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/model/quiz_details_model.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/labeled_radio_button.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/quiz_list_line.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';


class QuizStartPage extends StatefulWidget {
  final String quizId;
  const QuizStartPage({Key? key, required this.quizId}) : super(key: key);

  @override
  QuizStartPageState createState() => QuizStartPageState();
}



class QuizStartPageState extends State<QuizStartPage> {
  List<GivenAnswer> givenAnswerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'quiz_screen'.tr,),
      body: GetBuilder<QuizController>(
        initState: (state) => Get.find<QuizController>().getQuizDetails(int.parse(widget.quizId)),
        builder: (controller) {
          return FooterBaseWidget(
              child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: controller.isDataLoading ? const Center(child: CircularProgressIndicator(),): mainUI(context, controller.quizDetailsContent!),
              ));
        },
      ),
      //body: mainUI(context),
    );
  }

  Widget appBar(BuildContext context, QuizDetailsContent quiz) {
    return CustomAppBar(
      title: quiz.title,
      centerTitle: false,
      actions: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "5 m : 00 s",
            style: ubuntuBold.copyWith(
                color: Theme.of(context).primaryColorLight,
                fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeDefault),
      ],
    );
  }


  List<Widget> indicatorList(List<Questions> questionList) {
    return List.generate(
      questionList.length,
      (index) => CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.06),
        child: Text(
          "${index + 1}",
          style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }



  Widget questionItemDefault(Questions question, int index) => SizedBox(
      width:ResponsiveHelper.isWeb() ? Get.width: 290,
      child: LabeledRadioButton(
        question: question,
        isCorrectAnsSelected: (bool value) {
          GivenAnswer answer = GivenAnswer(
              question: question, isCorrect: value, selectedIndexes: [-1]);
          givenAnswerList[index] = answer;
        },
        selectedIndex: (int? value) {
          givenAnswerList[index].selectedIndexes = [value ?? -1];
        },
      ));



  List<Widget> questionListWidgets(List<Questions> list) => List.generate(
      list.length,
          (index) =>  questionItemDefault(list.elementAt(index), index));


  Widget mainUI(BuildContext context, QuizDetailsContent quizDetailsContent) {
    List<Questions> questionList = quizDetailsContent.questions??[];

    givenAnswerList.clear();
    for (var question in questionList) {
      givenAnswerList.add(GivenAnswer(
          question: question,
          isCorrect: false,
          selectedIndexes: [-1],
          shortQuestionAns: ""));
    }

    return Column(
      children: [
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        quizTopSection(context, quizDetailsContent),
        if (questionList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                QuizListLine(
                  padding: const EdgeInsets.symmetric(),
                  lineColor: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                  // indicators: indicatorList(questionList),
                  style: PaintingStyle.stroke,
                  indicatorSize: 0.0,
                  children: questionListWidgets(questionList),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                CustomButton(
                  onPressed: () => Get.toNamed(RouteHelper.getQuizDetailsScreen(givenAnswerList, quizDetailsContent)),
                  buttonText: 'submit'.tr,
                ),

              ],
            ),
          ),
      ],
    );
  }

  Widget quizTopSection(BuildContext context, QuizDetailsContent quiz) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(Images.quizTop,scale: 3,),
          const SizedBox(height: Dimensions.paddingSizeDefault,),

          const Text("Software Development Quiz Software Development Quiz",style: ubuntuMedium,),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(Images.timeDuration,scale: 2,),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  const Text("10:00 mins",style: ubuntuRegular,),
                ],
              ),
              const Text("Total Mark 10",style: ubuntuRegular,)
            ],
          )
        ],
      ),
    );
  }
}

class GivenAnswer {
  final Questions question;
  final bool isCorrect;
  List<int> selectedIndexes = [];
  String? shortQuestionAns = "";

  GivenAnswer(
      {required this.question,
      required this.selectedIndexes,
      required this.isCorrect,
      this.shortQuestionAns});

  Map<String, dynamic> toJson() {
    return {
      'question': question.toJson(),
      'isCorrect': isCorrect,
      'selectedIndexes': selectedIndexes,
      'shortQuestionAns': shortQuestionAns,
    };
  }

  factory GivenAnswer.fromJson(Map<String, dynamic> json) {
    return GivenAnswer(
      question: Questions.fromJson(json['question']),
      isCorrect: json['isCorrect'],
      selectedIndexes: List<int>.from(json['selectedIndexes']),
      shortQuestionAns: json['shortQuestionAns'],
    );
  }
}
