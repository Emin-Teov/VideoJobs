import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:video_list/pages/video_items.dart';

class SharedItem extends StatefulWidget {
  final int id;
  final int index;
  final Uint8List thumbnail;
  final List data;

  const SharedItem({
    super.key,
    required this.id,
    required this.index,
    required this.thumbnail,
    required this.data,
  });

  @override
  State<SharedItem> createState() => _SharedItemState();
}

class _SharedItemState extends State<SharedItem> {
  List<String> url = ['job_seeker', 'job_offer', 'freelancer'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
              image: MemoryImage(widget.thumbnail),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
