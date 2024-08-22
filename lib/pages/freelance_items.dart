import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:video_list/models/freelancer_model.dart';
import 'package:video_list/pages/shared_item.dart';

class FreelanceItems extends StatefulWidget {
  final int item_index;
  final List<FreelancerModel> items;

  const FreelanceItems({
    super.key,
    required this.item_index,
    required this.items,
  });

  @override
  State<FreelanceItems> createState() => _FreelanceItemsState();
}

class _FreelanceItemsState extends State<FreelanceItems> {
  late List<List<Uint8List>> getThumbnails;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Expanded(
        child: GridView.builder(
            itemCount: widget.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: ((size.width / 3) /
                  ((size.height - kToolbarHeight - 24) / 2)),
              mainAxisSpacing: 124.0,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SharedItem(
                id: widget.items[index].id,
                index: widget.item_index,
                data: widget.items.sublist(index, widget.items.length),
              );
            }),
      ),
    );
  }
}
