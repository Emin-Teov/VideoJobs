import 'package:flutter/material.dart';
import 'package:video_list/models/video_model.dart';
import 'package:video_list/pages/video_item.dart';

class VideoItems extends StatefulWidget {
  final List<VideoModel> data;

  const VideoItems({
    super.key,
    required this.data
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: [
          ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) {
              var size = MediaQuery.of(context).size;
              return Container(
                width: size.width,
                height: size.height,
                child: VideoItem(url: widget.data[index].url, name: widget.data[index].name, surname: widget.data[index].surname, title: widget.data[index].title),
              );
            }
          ),
        ],
      ),
    );
  }
}
