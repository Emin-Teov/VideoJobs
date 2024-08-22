import 'dart:core';

import 'package:flutter/material.dart';

import 'package:video_list/models/job_seeker_model.dart';
import 'package:video_list/models/offer_model.dart';
import 'package:video_list/models/freelancer_model.dart';
import 'package:video_list/pages/freelance_items.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/job_seeker_items.dart';
import 'package:video_list/pages/offer_items.dart';

List<JobSeekerModel> parseJobSeekers(List<dynamic> responseBody) {
  List<JobSeekerModel> parsed = [];
  for (dynamic body in responseBody) {
    parsed.add(JobSeekerModel.fromJson(body));
  }
  return parsed;
}

List<OfferModel> parseOffers(List<dynamic> responseBody) {
  List<OfferModel> parsed = [];
  for (dynamic body in responseBody) {
    parsed.add(OfferModel.fromJson(body));
  }
  return parsed;
}

List<FreelancerModel> parseFreelancers(List<dynamic> responseBody) {
  List<FreelancerModel> parsed = [];
  for (dynamic body in responseBody) {
    parsed.add(FreelancerModel.fromJson(body));
  }
  return parsed;
}

class HomeList extends StatefulWidget {
  final List job_seekers;
  final List offers;
  final List freelancers;

  const HomeList({
    super.key,
    required this.job_seekers,
    required this.offers,
    required this.freelancers
  });

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  int _tab_index = 0;
  late List <Widget> _list_shared_items;

  @override
  void initState() {
    super.initState();
    
    _list_shared_items = [
      JobSeekerItems(item_index: 0, items: parseJobSeekers(widget.job_seekers)),
      OfferItems(item_index: 1, items: parseOffers(widget.offers)),
      FreelanceItems(item_index: 2, items: parseFreelancers(widget.freelancers)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          width: 400,
          child: TextField(
            scrollPadding: EdgeInsets.all(25),
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: EdgeInsets.all(12),
              icon: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.search,
                  color: Colors.amberAccent,
                ),
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  _tab_index = 0;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.person_pin_rounded,
                    color: Colors.white70,
                  ),
                  GetTextField(
                    text: _tab_index == 0 ? 'I need job' : '',
                    light: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  _tab_index = 1;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.local_offer,
                    color: Colors.white70,
                  ),
                  GetTextField(
                    text: _tab_index == 1 ? 'Job offers' : '',
                    light: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  _tab_index = 2;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.home_repair_service,
                    color: Colors.white70,
                  ),
                  GetTextField(
                    text: _tab_index == 2 ? 'Services' : '',
                    light: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: _list_shared_items[_tab_index],
        ),
      ],
    );
  }
}
