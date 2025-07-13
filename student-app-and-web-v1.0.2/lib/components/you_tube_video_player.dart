import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubeVideoPlayer extends StatefulWidget {
  final String videoLinkPath;
  const YouTubeVideoPlayer({Key? key, required this.videoLinkPath}) : super(key: key);

  @override
  State<YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  late YoutubePlayerController _youtubePlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.videoLinkPath)!,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),



    );

  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: YoutubePlayer(controller: _youtubePlayerController),
    );
  }
}
