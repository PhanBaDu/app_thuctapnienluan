import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/course/model/course_details_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';


class CourseCurriculum extends StatelessWidget {
  final List<Sections>? sections;

  const CourseCurriculum({Key? key, required this.sections}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('course_curriculum'.tr,
              style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          //curriculumItem(context),
          SizedBox(
            //height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sections!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                  bottom:Dimensions.paddingSizeSmall
                  ),
                  child: curriculumItem(sections!.elementAt(index),context),
                );
              },
            ),
          ),
          //const SizedBox(height: 10,),
          //foldedItem(context),
        ],
      ),
    );
  }

  Container curriculumItem(Sections sections,BuildContext context){
    return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall),
            ),
          ),
      child: ExpansionTile(
        collapsedIconColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        title: Text(sections.topic!,
            style: ubuntuMedium.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Dimensions.fontSizeDefault),
        ),
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context)
                .textTheme
                .bodyLarge!
                .color!
                .withOpacity(0.06),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sections.lessons!.length,
              itemBuilder: (context,index){
                return _item(sections.lessons!.elementAt(index) ,context);
              },
            ),
          ),
        ],
      ),
    );
  }


  Padding _item(Lessons lessons,BuildContext context) {
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
              Text(lessons.lectureTitle!,
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
