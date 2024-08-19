import 'package:flutter/material.dart';
import 'package:video_list/models/offer_model.dart';
import 'package:video_list/pages/offer_item.dart';

class OfferItems extends StatefulWidget {
  final List<OfferModel> items;

  const OfferItems({
    super.key,
    required this.items
  });

  @override
  State<OfferItems> createState() => _OfferItemsState();
}

class _OfferItemsState extends State<OfferItems> {
  late Future<List<OfferModel>> futureOffers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(25),
            child: OfferItem(
              id: widget.items[index].id,
              tittle: widget.items[index].title,
              employer_id: widget.items[index].employer_id,
              employer: widget.items[index].ceo,
              video: widget.items[index].video,
              description: widget.items[index].description,
              data: widget.items
                  .sublist(index, widget.items.length),
            ),
          );
        }
      ),
    );
  }
}
