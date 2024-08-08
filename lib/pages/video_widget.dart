import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;

  const VideoWidget({
    super.key,
    required this.url
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late final VideoPlayerController videoController;
  @override
  void initState() {
    videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        videoController.play();
        videoController.setLooping(true);
      });
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => VideoPlayer(videoController);
}
