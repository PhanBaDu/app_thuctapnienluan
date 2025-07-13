import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CourseFeatures extends StatelessWidget {
  const CourseFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: Text(
              'course_features'.tr,
              style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 32 / 7,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                primary: false,
                // padding: const EdgeInsets.all(20),
                children: [
                  featureCade(context, Images.profile, "0 Enroll"),
                  // featureCade(context, Images.playCircle, feature.totalVideos ?? "0 Video Record"),
                  // featureCade(context, Images.book, feature.totalLesson ?? "0 Lessons"),
                  // featureCade(context, Images.noteFile, feature.totalNoteFiles ?? "0 Note File"),
                  // featureCade(context, Images.quiz, feature.totalQuiz ?? "0 Quiz"),
                  // featureCade(context, Images.microPhone, feature.totalAudioFiles ?? "0 Audio Record"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget featureCade(context, String icon, String title) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color:
              Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.06),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Row(
        children: [
          Container(
            width: 40,
            //height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusSmall),
                bottomLeft: Radius.circular(Dimensions.radiusSmall),
              ),
            ),
            // child: Center(
            //   child: SvgPicture.asset(icon),
            // ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text(
            title,
            style: ubuntuRegular.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.6),
                fontSize: Dimensions.fontSizeSmall),
          )
        ],
      ),
    );
  }
}
