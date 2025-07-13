import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CourseReview extends StatelessWidget {
  final int totalReview;
  final String avgRatings;
  final bool isReviewed;
  final bool isCanReview;
  const CourseReview(
      {Key? key,
      required this.totalReview,
      required this.avgRatings,
      required this.isReviewed,
      required this.isCanReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'course_review'.tr,
                style: ubuntuMedium .copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyLarge!.color!
                ),
              ),
              isCanReview == false
                  ? const SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radiusSmall),
                          bottomLeft: Radius.circular(Dimensions.radiusSmall),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                            vertical: Dimensions.paddingSizeRadius),
                        child: Text(
                          'write_review'.tr,
                          style: ubuntuMedium.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SizedBox(
            //height: 78,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      avgRatings,
                      style: ubuntuMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      "($totalReview Review)",
                      style: ubuntuRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.5),
                          fontSize: Dimensions.fontSizeExtraSmall),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06)),
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.radiusSmall)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: Dimensions.paddingSizeSmall),
                        child: CircleAvatar(
                          radius: 20,
                          child:
                              ClipOval(child: Image.asset(Images.profileThumbnail)),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hellio Jamsh",
                                  style: ubuntuMedium.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!,
                                      fontSize: Dimensions.fontSizeDefault),
                                ),

                              ],
                            ),
                            Text("Student  |  21 Jan 2023",
                                style: ubuntuRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.6),
                                    fontSize: Dimensions.fontSizeExtraSmall)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "English course designed to teach kids how to speak English in real life situations.",
                    style: ubuntuMedium.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
