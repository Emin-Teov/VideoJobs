import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:video_list/pages/cv_resume.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/get_text_label.dart';

class VideoItem extends StatefulWidget {
  final int id;
  final int index;
  final int employer_id;
  final String user;
  final String title;
  final String description;

  const VideoItem({
    super.key,
    required this.id,
    required this.index,
    required this.employer_id,
    required this.user,
    required this.title,
    required this.description,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool _like_clicked = false;
  List<String> video_url = ['job_seeker', 'job_offer', 'freelancer', 'talent'];
  List<String> image_url = [
    'profile/profile_image',
    'logo/photo_logo',
    'profile/freelancer_profile',
    'profile/talent'
  ];
  late final VideoPlayerController videoController;

  void setDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: widget.index == 1
            ? Theme.of(context).dialogBackgroundColor
            : Theme.of(context).colorScheme.inversePrimary,
            content: widget.index == 1
            ? Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Center(
                    child: GetTextField(
                      text: 'Description:',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                        ),
                      )
                    ),
                  )
                ],
              )
            : CVResume(
                id: widget.id,
                user: widget.user,
                index: widget.index,
              ),
          );
        });
  }

  void liked() {
    setState(() {
      _like_clicked = !_like_clicked;
    });
  }

  @override
  void initState() {
    videoController = VideoPlayerController.networkUrl(Uri.parse('https://emin-teov.github.io/api/video/${video_url[widget.index]}_${widget.id}.mp4'))
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          VideoPlayer(videoController),
          VideoProgressIndicator(
            videoController, 
            allowScrubbing: true, 
            colors: VideoProgressColors(
              playedColor: Colors.redAccent,
              bufferedColor: Colors.white70,
              backgroundColor: Colors.white10,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Image.network(
                      width: 50,
                      height: 50,
                      'https://emin-teov.github.io/api/${image_url[widget.index]}-${widget.index == 1 ? widget.employer_id : widget.id}.png',
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return widget.index == 1
                          ? const ImageIcon(
                              AssetImage('assets/icons/ceo.png'),
                              color: Colors.amberAccent,
                              size: 36,
                            )
                          : Icon(
                               widget.index == 3
                                ? Icons.person_search
                                : Icons.person,
                              size: 50,
                              color: Colors.blueGrey,
                            );
                      },
                    ),
                    Expanded(
                      child: GetTextLabel(
                        head: widget.user,
                        value: widget.title,
                        light: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: liked,
                          icon: Icon(
                            Icons.handshake,
                            size: 36,
                            color: _like_clicked ? Colors.red : Colors.blueGrey,
                          ),
                        ),
                        widget.index == 1
                          ? IconButton(
                              onPressed: setDialog,
                              icon: Icon(
                                Icons.attach_file,
                                size: 36,
                                color: Colors.amberAccent,
                              ),
                            )
                          : GestureDetector(
                              onTap: setDialog,
                              child: ImageIcon(
                                AssetImage("assets/icons/${widget.index == 3 ? 'talent' : 'cv'}.png"),
                                color: Colors.amberAccent,
                                size: 36,
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
