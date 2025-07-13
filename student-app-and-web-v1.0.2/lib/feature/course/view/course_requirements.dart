import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';


class CourseRequirements extends StatelessWidget {
  final String requirements;

  const CourseRequirements({Key? key, required this.requirements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('course_requirements'.tr,
            style: ubuntuBold.copyWith(
                fontSize: Dimensions.fontSizeDefault),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          //curriculumItem(context),
          Text(requirements,style: ubuntuRegular,)
          //const SizedBox(height: 10,),
          //foldedItem(context),
        ],
      ),
    );
  }
}
