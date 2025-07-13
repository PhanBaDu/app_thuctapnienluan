import 'package:flutter/material.dart';
import 'package:get_lms_flutter/feature/myLearning/model/mylearning_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class LessonWidget extends StatelessWidget {
  final Lessons lesson;
  const LessonWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // SvgPicture.asset(Images.polygon),
              const SizedBox(width: 15),
              Text(lesson.title!,
                  style: ubuntuRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                      fontSize: Dimensions.fontSizeSmall)),
            ],
          ),
        ],
      ),
    );;
  }
}
