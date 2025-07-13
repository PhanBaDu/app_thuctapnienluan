import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_video_player.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/you_tube_video_player.dart';
import 'package:get_lms_flutter/core/helper/date_converter.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/course/controller/course_details_controller.dart';
import 'package:get_lms_flutter/feature/course/controller/course_details_tab_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_details_model.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/course/view/course_description.dart';
import 'package:get_lms_flutter/feature/course/view/course_overview.dart';
import 'package:get_lms_flutter/feature/course/view/course_requirements.dart';
import 'package:get_lms_flutter/feature/course/widget/course_curriculum.dart';
import 'package:get_lms_flutter/feature/course/widget/course_details_buttons.dart';
import 'package:get_lms_flutter/feature/course/widget/course_includes.dart';
import 'package:get_lms_flutter/feature/course/widget/related_course.dart';
import 'package:get_lms_flutter/feature/course/widget/what_you_will_learn.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseID;

  const CourseDetailsScreen({Key? key, required this.courseID}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(centerTitle: false, title: 'course_details'.tr,showCart: true,),
      body: GetBuilder<CourseDetailsController>(
          initState: (state) {
            Get.find<CourseDetailsController>().getCourseDetails(widget.courseID);
            },
          builder: (courseController) {
            if(courseController.courseDetailsContent != null){
              CourseDetailsContent? courseDetailsContent = courseController.courseDetailsContent;

                  return FooterBaseWidget(
                      child: SizedBox(
                        width: Dimensions.webMaxWidth,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(!ResponsiveHelper.isMobile(context))
                                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.orange.withOpacity(0.2),
                                    child:courseDetailsContent!.videoSourceType != null && courseDetailsContent.videoSourceType == "youtube" ?
                                    YouTubeVideoPlayer(videoLinkPath: courseDetailsContent.videoLinkPath!):
                                    CourseVideoPlayer(courseIntroVideo: courseDetailsContent.videoSourceType == "vimeo" ? courseDetailsContent.videoLinkPath! : courseDetailsContent.courseIntroVideo!,),
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  CourseOverView(
                                    title: courseDetailsContent.title!,
                                    description: courseDetailsContent.subTitle!,
                                    instructor: 'Ashutosh Pawar',
                                    lastUpdate: DateConverter.stringToLocalDateOnly(courseDetailsContent.updatedAt!),

                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                    child: Text(
                                      PriceFormatter.formatPrice(courseDetailsContent.price!.toDouble()),
                                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeOverLarge),),
                                  ),
                                  CourseButtons(course: Course(
                                    title: courseDetailsContent.title,
                                    id: courseDetailsContent.id,
                                    categoryId: courseDetailsContent.categoryId,
                                    subCategoryId: courseDetailsContent.subCategoryId,
                                    price: courseDetailsContent.price,
                                    learningTopic: courseDetailsContent.learningTopic,
                                  ),),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  WhatYouWillLearn(whatWillLearn: courseDetailsContent.learningTopic!),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  CourseCurriculum(sections: courseDetailsContent.sections,),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  CourseIncludes(title: 'this_course_includes'.tr,),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  CourseRequirements(requirements: courseDetailsContent.requirements!),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  CourseDescription(description: courseDetailsContent.description!),
                                  RelatedCourse(courses: courseDetailsContent.moreCourse!,),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                          ]),
                        ),
                      )
                     );
            }else{
                  return const Center(child: CircularProgressIndicator());
            }
      }),
    );
  }
}


