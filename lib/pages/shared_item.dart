import 'dart:typed_data';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';

import '/pages/has_error.dart';
import '/pages/get_text_label.dart';
import '/pages/video_items.dart';

Future<Uint8List> getThumbnailImage(String url) async {
  final thumbnail = await VideoThumbnail.thumbnailData(
      video: 'https://emin-teov.github.io/api/video/${url}.mp4',
      imageFormat: ImageFormat.PNG);
  return thumbnail;
}

class SharedItem extends StatefulWidget {
  final int id;
  final int index;
  final String user;
  final String title;
  final List data;

  const SharedItem({
    super.key,
    required this.id,
    required this.index,
    required this.user,
    required this.title,
    required this.data,
  });

  @override
  State<SharedItem> createState() => _SharedItemState();
}

class _SharedItemState extends State<SharedItem> {
  List<String> _url = ['job_seeker', 'job_offer', 'freelancer', 'talent'];
  late Future<Uint8List> thumbnail;

  @override
  void initState() {
    super.initState();
    thumbnail = getThumbnailImage('${_url[widget.index]}_${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Uint8List>(
        future: thumbnail,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return HasError();
          } else if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoItems(
                    data: widget.data,
                    index: widget.index,
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(snapshot.data!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: GetTextLabel(
                              head: widget.user,
                              value: widget.title,
                              light: true,
                              small: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.all(5.0),
              color: Color(0x3A9E9E9E),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
