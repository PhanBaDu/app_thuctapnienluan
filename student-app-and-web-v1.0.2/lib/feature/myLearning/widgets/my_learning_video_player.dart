import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/my_learning_video_player_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/mylearning_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/model/lastViewedCourse_model.dart';
import 'package:get_lms_flutter/feature/myLearning/model/mylearning_model.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class MyLearningVideoPlayer extends StatelessWidget {
  final List<Sections>? sections;
  final String courseId;
  const MyLearningVideoPlayer({super.key, required this.sections, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyVideoPlayerController>(
      initState: (state){
        Get.find<MyLearningController>().getLastViewedCourse().then((value) {
          LastViewedCourseContent? lastViewedCourseContent = Get.find<MyLearningController>().lastViewedCourseContent;
          printLog("lastViewedCourseContent");
          if(lastViewedCourseContent != null){
            Get.find<MyVideoPlayerController>().playVideo(
              url: sections!.elementAt(lastViewedCourseContent.lastViewedSection!).lessons!.elementAt(lastViewedCourseContent.lastViewedLesson!).videoLinkPath!,
              // url: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
              courseID: lastViewedCourseContent.lastViewedCourse!.toString(),
              sectionIndex: lastViewedCourseContent.lastViewedSection!.toString(),
              lessonId: sections!.elementAt(lastViewedCourseContent.lastViewedSection!).lessons!.elementAt(lastViewedCourseContent.lastViewedLesson!).id.toString(),
              isLessonCompleted: sections!.elementAt(0).lessons!.elementAt(0).isCompleted == '1',
              lastViewedLessonPosition: lastViewedCourseContent.lastViewedLesson!.toString(),
            );
          }else{
            printLog("inside_else");
            Get.find<MyVideoPlayerController>().playVideo(
              url: "${AppConstants.baseUrl}${sections!.elementAt(0).lessons!.elementAt(0).videoLinkPath!}",
              courseID: courseId,
              sectionIndex: '0',
              lessonId: sections!.elementAt(0).lessons!.elementAt(0).id.toString(),
              lastViewedLessonPosition: '0',
              isLessonCompleted: false,
            );
          }

        });
      },
      builder: (MyVideoPlayerController controller) {
        if(controller.startPlaying){
          return AspectRatio(
            aspectRatio: controller.videoPlayerController!.value.aspectRatio,
            child:Chewie(controller: controller.chewieController!),
          );
        }
        else{
          return SizedBox(
            width: Get.width,
            height: 200.0,
            child: Center(child: Text('loading'.tr)),
          );
        }

      },);
  }
}
