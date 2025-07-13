import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';


class CourseDescription extends StatelessWidget {
  final String description;

  const CourseDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('description'.tr,
            style: ubuntuBold.copyWith(
                fontSize: Dimensions.fontSizeDefault),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          //curriculumItem(context),
          Text(description,style: ubuntuRegular,)
          //const SizedBox(height: 10,),
          //foldedItem(context),
        ],
      ),
    );
  }
}
