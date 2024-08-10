import 'package:flutter/material.dart';
import 'package:video_list/pages/video_item.dart';

class VideoItems extends StatefulWidget {
  final List data;
  final bool ceo;

  const VideoItems({
    super.key,
    required this.data,
    this.ceo = false,
  });

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
            id: widget.ceo ? widget.data[i].employer_id : widget.data[i].id,
            url: widget.data[i].url,
            user: widget.ceo ? widget.data[i].ceo : '${widget.data[i].name} ${widget.data[i].surname}',
            title: widget.data[i].title, 
            ceo: widget.ceo,
            description: widget.ceo ? widget.data[i].description : "",
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
