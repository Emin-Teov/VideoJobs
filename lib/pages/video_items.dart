import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/pages/video_item.dart';

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
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  getReel(var size) {
    List<Widget> reel = [];
    for (int i = 0; i < widget.data.length; i++) {
      reel.add(
        SizedBox(
          height: size.height,
          width: size.width,
          child: VideoItem(
            id: widget.data[i].id,
            index: widget.index,
            employer: widget.index == 1 ? widget.data[i].employer : 0,
            username: widget.index == 0
                ? '${widget.data[i].name} ${widget.data[i].surname}'
                : widget.index == 1
                    ? widget.data[i].ceo
                    : widget.data[i].username,
            title: AppLocalizations.of(context).categories(widget.data[i].employment),
            description: widget.index == 1 ? widget.data[i].description : '',
            email: widget.data[i].email,
          ),
        ),
      );
    }
    return reel;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? size.width
              : size.width / 3,
          height: size.height,
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: controller,
            children: getReel(size),
          ),
        ),
      ),
    );
  }
}
