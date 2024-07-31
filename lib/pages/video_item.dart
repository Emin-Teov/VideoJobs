import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final int id;
  final String url;
  final String username;
  final String title;

  const VideoItem({
    super.key,
    required this.id,
    required this.url,
    required this.username,
    required this.title,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    ));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  void showResume() {
    showDialog(
        context: context,
        builder: (context) {
          return AboutDialog(
            children: <Widget>[
              GetTextField(
                text: widget.username,
              ),
              Container(
                width: 450,
                height: 450,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    'lib/resumes/cv_resume-${widget.id}.png',
                    width: 450,
                    height: 450,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: FlickVideoPlayer(flickManager: flickManager),
        ),
        GetTextField(text: widget.username),
        GetTextField(text: widget.title),
        IconButton(onPressed: showResume, icon: const Icon(Icons.file_copy)),
      ],
    );
  }
}
