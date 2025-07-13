import 'package:flutter/material.dart';
import 'package:get_lms_flutter/feature/myLearning/model/mylearning_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class QuizWidget extends StatelessWidget {
  final Quiz quizs;
  const QuizWidget({super.key, required this.quizs});

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
              Text(quizs.title!,
                  style: ubuntuRegular.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.6),
                      fontSize: Dimensions.fontSizeSmall)),
            ],
          ),
        ],
      ),
    );
  }
}
