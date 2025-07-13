import 'dart:async';
import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/mylearning_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyVideoPlayerController extends GetxController implements GetxService {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  ChewieController? get chewieController => _chewieController;

  bool _startPlaying = false;
  bool get startPlaying => _startPlaying;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void playVideo({
                    required String url,
                    required String courseID,
                    required String sectionIndex,
                    required String lessonId,
                    required bool isLessonCompleted, required String lastViewedLessonPosition}) async {

    Get.find<MyLearningController>().getCurrentViewedCourse(
      courseID: courseID,
      sectionIndex: sectionIndex,
      lessonIndex: lastViewedLessonPosition,
    );

    if(_videoPlayerController != null) {
      await stopPlayer();
    }

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(url),
    );
    await _videoPlayerController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
    );
    _chewieController!.play();
    _startPlaying = true;
    _videoPlayerController!.addListener(() {

      // Implement your calls inside these conditions' bodies :
      if(videoPlayerController!.value.position == const Duration(seconds: 0, minutes: 0, hours: 0)) {
        Get.find<MyLearningController>().lastViewedCourse(courseID: courseID, sectionIndex: sectionIndex, lessonIndex: lastViewedLessonPosition);
        Get.find<MyLearningController>().lessonMarkAsComplete(lessonID: lessonId);
      }
    });
    update();
  }

  Future<void> stopPlayer() async {
    _videoPlayerController!.dispose();
    update();
  }

  @override
  void dispose() {
    _chewieController!.dispose();
    _videoPlayerController!.dispose();
    super.dispose();
  }

}
