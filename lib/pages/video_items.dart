import 'package:flutter/material.dart';
import 'package:video_list/models/video_model.dart';
import 'package:video_list/pages/video_item.dart';

class VideoItems extends StatefulWidget {
  final List<VideoModel> data;

  const VideoItems({super.key, required this.data});

  @override
  State<VideoItems> createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late PageController _controller;
  late List<Widget> reel = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.data.length; i++) {
      reel.add(
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: VideoItem(
            url: widget.data[i].url,
            name: widget.data[i].name,
            surname: widget.data[i].surname,
            title: widget.data[i].title
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          children: reel,
        ),
      ),
    );
  }
}
