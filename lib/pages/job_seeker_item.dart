import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:video_list/models/job_seeker_model.dart';
import 'dart:typed_data';

import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/video_items.dart';

Future<Uint8List> getThumbnailImage(String url) async {
  final thumbnail = await VideoThumbnail.thumbnailData(
      video: url, imageFormat: ImageFormat.PNG);
  return thumbnail;
}

class JobSeekerItem extends StatefulWidget {
  final String url;
  final List<JobSeekerModel> data;

  const JobSeekerItem({
    super.key,
    required this.url,
    required this.data,
  });

  @override
  State<JobSeekerItem> createState() => _JobSeekerItemState();
}

class _JobSeekerItemState extends State<JobSeekerItem> {
  late Future<Uint8List> thumbnail;

  @override
  void initState() {
    super.initState();
    thumbnail = getThumbnailImage(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Uint8List>(
        future: thumbnail,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error),
                  GetTextField(text: "An error has occurred!"),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>VideoItems(data: widget.data))
              ),
              child: Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(snapshot.data!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
