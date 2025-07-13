import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_lms_flutter/components/course_view_verticle.dart';
import 'package:get_lms_flutter/components/paginated_list_view.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

import '../model/course_model.dart';


class RelatedCourse extends StatelessWidget {
  final List<Course> courses;
  const RelatedCourse({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
          child: Text(
            'more_course_by_instructor_name'.tr,
            style:
                ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        CourseViewVertical(
          course: courses,
          padding: const EdgeInsets.symmetric(
            horizontal:  Dimensions.paddingSizeDefault,
            vertical: 0,),
          type: 'others',
          noDataType: EmptyScreenType.home,
        ),
      ],
    );
  }
}
