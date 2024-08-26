import 'package:flutter/material.dart';
import 'package:video_list/pages/video_item.dart';

class VideoItems extends StatefulWidget {
  final List data;
  final int index;

  const VideoItems({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  State<VideoItems> createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  getReel(var size) {
    List<Widget> reel = [];
    for (int i = 0; i < widget.data.length; i++) {
      reel.add(
        Container(
          height: size.height,
          width: size.width,
          child: VideoItem(
            id: widget.data[i].id,
            index: widget.index,
            employer_id: widget.index == 1 ? widget.data[i].employer_id : 0,
            user: widget.index == 0
              ? '${widget.data[i].name} ${widget.data[i].surname}'
              : widget.index == 1
                ? widget.data[i].ceo
                : widget.data[i].user,
            title: widget.data[i].title,
            description: widget.index == 1 ? widget.data[i].description : '',
          ),
        ),
      );
    }
    return reel;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
            ? size.width
            : size.width / 3,
          height: size.height,
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: _controller,
            children: getReel(size),
          ),
        ),
      ),
    );
  }
}
