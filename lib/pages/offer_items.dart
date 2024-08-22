import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:video_list/models/offer_model.dart';
import 'package:video_list/pages/shared_item.dart';

class OfferItems extends StatefulWidget {
  final int item_index;
  final List<OfferModel> items;

  const OfferItems({
    super.key,
    required this.item_index,
    required this.items,
  });

  @override
  State<OfferItems> createState() => _OfferItemsState();
}

class _OfferItemsState extends State<OfferItems> {
  late List<List<Uint8List>> getThumbnails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.builder(
              itemCount: widget.items.length, 
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              ),
              itemBuilder: (BuildContext context, int index) { 
                return SharedItem(
                  id: widget.items[index].id,
                  index: widget.item_index,
                  user: widget.items[index].ceo,
                  title: widget.items[index].title,
                  data: widget.items.sublist(index, widget.items.length),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
