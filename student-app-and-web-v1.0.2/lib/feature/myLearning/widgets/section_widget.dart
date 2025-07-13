import 'package:flutter/material.dart';
import 'package:get_lms_flutter/feature/myLearning/model/mylearning_model.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/lesson_widget.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/quiz_widget.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SectionWidget extends StatelessWidget {
  final Sections section;
  const SectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(

        border: Border.all(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          width: 1,
        ),
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall),
        ),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        title: Text(section.title!,
          style: ubuntuMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Dimensions.fontSizeDefault),
        ),
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context)
                .textTheme
                .bodyLarge!
                .color!
                .withOpacity(0.06),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: section.lessons!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return LessonWidget(lesson:section.lessons!.elementAt(index));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: section.quizs!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return QuizWidget(quizs:section.quizs!.elementAt(index));
              },
            ),
          ),
        ],
      ),
    );
  }
}
