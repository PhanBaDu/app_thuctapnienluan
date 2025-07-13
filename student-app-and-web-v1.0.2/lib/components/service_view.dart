import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_shimmer.dart';
import 'package:get_lms_flutter/components/course_widget.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ServiceView extends StatelessWidget {
  final List<Course>? service;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final Function(String type)? onVegFilterTap;
  const ServiceView({super.key, required this.service, this.isScrollable = false, this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall), this.noDataText, this.type, this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;
    isNull = service == null;
    if(!isNull) {
      length = service!.length;
    }

    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.fontSizeDefault),
        child: Text('sub_categories'.tr,style: ubuntuBold.copyWith(
            fontSize: Dimensions.fontSizeDefault,

            color: Theme.of(context).primaryColor),),
      ),
      !isNull ? length > 0 ? GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: Dimensions.paddingSizeLarge,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
          childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 3.5,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        ),
        physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        shrinkWrap: isScrollable! ? false : true,
        itemCount: length,
        padding: padding,
        itemBuilder: (context, index) {
          return CourseWidget(course: service![index]);
        },
      ) : EmptyScreen(
        text: noDataText ?? 'no_services_found'.tr,
      ) : GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: Dimensions.paddingSizeLarge,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : 0.01,
          childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 4,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        ),
        physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        shrinkWrap: isScrollable! ? false : true,
        itemCount: shimmerLength,
        padding: padding,
        itemBuilder: (context, index) {
          return CourseShimmer(isEnabled: isNull, hasDivider: index != shimmerLength!-1);
        },
      ),

    ]);
  }
}
