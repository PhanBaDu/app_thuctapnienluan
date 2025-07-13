import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String courseIntroVideo;
  const CourseVideoPlayer({Key? key, required this.courseIntroVideo}) : super(key: key);

  @override
  State<CourseVideoPlayer> createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.courseIntroVideo));

    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
    );
    _chewieController.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child:Chewie(controller: _chewieController),

    );
  }
}
