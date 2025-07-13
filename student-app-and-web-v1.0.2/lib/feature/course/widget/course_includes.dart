import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/title_view.dart';
import 'package:get_lms_flutter/feature/course/model/course_includes.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/instructor/model/instructor_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CourseIncludes extends StatelessWidget {
  final String title;
  const CourseIncludes(
      {Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<CourseIncludesModel> includes = [
      CourseIncludesModel(icon: Images.supportedFile, name: 'supported_file'.tr),
      CourseIncludesModel(icon: Images.accessOnPhone, name: 'access_on_mobile_web'.tr),
      CourseIncludesModel(icon: Images.certificateIcon, name: 'certificate_of_completion'.tr),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
          child: Text(title.tr, style: ubuntuMedium,),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        ListView.builder(
            itemCount: includes.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              CourseIncludesModel instructor = includes.elementAt(index);
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                      child: Image.asset(
                        instructor.icon ?? "",
                        fit: BoxFit.contain,
                        scale: 3,
                      ),
                    ),
                    Expanded(
                      child: Text(instructor.name!)
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
