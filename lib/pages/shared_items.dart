import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:video_list/models/freelancer_model.dart';
import 'package:video_list/models/job_seeker_model.dart';
import 'package:video_list/models/offer_model.dart';
import 'package:video_list/pages/shared_item.dart';

class SharedItems extends StatefulWidget {
  final int item_index;

  final List<JobSeekerModel> job_seekers;
  final List<OfferModel> offers;
  final List<FreelancerModel> freelancers;

  final List<Uint8List> getThumbnailsJobSeekers;
  final List<Uint8List> getThumbnailsOffers;
  final List<Uint8List> getThumbnailsFreelancers;

  const SharedItems({
    super.key,
    required this.item_index,
    required this.job_seekers,
    required this.offers,
    required this.freelancers,
    required this.getThumbnailsJobSeekers,
    required this.getThumbnailsOffers,
    required this.getThumbnailsFreelancers,
  });

  @override
  State<SharedItems> createState() => _SharedItemsState();
}

class _SharedItemsState extends State<SharedItems> {
  late List _items;
  late List<List<Uint8List>> getThumbnails;

  @override
  void initState() {
    super.initState();

    _items = [widget.job_seekers, widget.offers, widget.freelancers];
    getThumbnails = [
      widget.getThumbnailsJobSeekers,
      widget.getThumbnailsOffers,
      widget.getThumbnailsFreelancers
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Expanded(
        child: GridView.builder(
            itemCount: _items[widget.item_index].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: ((size.width / 3) /
                  ((size.height - kToolbarHeight - 24) / 2)),
              mainAxisSpacing: 124.0,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SharedItem(
                id: _items[widget.item_index][index].id,
                index: widget.item_index,
                thumbnail: getThumbnails[widget.item_index][index],
                data: _items[widget.item_index].sublist(index, _items[widget.item_index].length),
              );
            }),
      ),
    );
  }
}
