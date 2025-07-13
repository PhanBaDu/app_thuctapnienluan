import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_shimmer.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'course_widget.dart';

class CourseViewVertical extends StatelessWidget {
  final List<Course>? course;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final EmptyScreenType? noDataType;
  final Function(String type)? onVegFilterTap;

  const CourseViewVertical(
      {super.key,
      required this.course,
      this.isScrollable = false,
      this.shimmerLength = 20,
      this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall),
      this.noDataText,
      this.type,
      this.onVegFilterTap,
      this.noDataType});

  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;

    isNull = course == null;
    if (!isNull) {
      length = course!.length;
    }

    return Column(
      children: [
        !isNull ? length > 0 ?
        GridView.builder(
          key: UniqueKey(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.paddingSizeDefault,
            mainAxisSpacing: Dimensions.paddingSizeDefault,
            childAspectRatio: ResponsiveHelper.isTab(context) ? .9 : .63,
            mainAxisExtent: ResponsiveHelper.isMobile(context) ? 265 : 275,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 2: ResponsiveHelper.isTab(context) ? 3 : 5,
          ),
          physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          shrinkWrap: isScrollable! ? false : true,
          itemCount: course?.length,
          padding: padding,
          itemBuilder: (context, index) {
            return CourseWidget(course: course?.elementAt(index));
          },
        ):
        SizedBox(
          height: Get.height / 2.2,
          child: EmptyScreen(
              text: noDataText ?? 'no_course_found'.tr,
              type: noDataType),):

        GridView.builder(
          key: UniqueKey(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.paddingSizeDefault,
            mainAxisSpacing:  Dimensions.paddingSizeDefault,
            childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .72,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,),
          physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          shrinkWrap: isScrollable! ? false : true,
          itemCount: shimmerLength,
          padding: padding,
          itemBuilder: (context, index) {
            return CourseShimmer(isEnabled: true, hasDivider: index != shimmerLength! - 1);
          },
        ),

      ],
    );
  }
}
