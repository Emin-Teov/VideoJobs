import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/job_seeker_model.dart';
import '/models/offer_model.dart';
import '/models/freelancer_model.dart';
import '/models/talent_model.dart';
import '/pages/get_text_field.dart';
import '/pages/search_field.dart';
import '/pages/shared_items.dart';

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

List<TalentModel> parseTalents(List<dynamic> responseBody) {
  List<TalentModel> parsed = [];
  for (dynamic body in responseBody) {
    parsed.add(TalentModel.fromJson(body));
  }
  return parsed;
}

class HomeList extends StatefulWidget {
  final List job_seekers;
  final List offers;
  final List freelancers;
  final List talents;
  final Set<String> country_query;
  final Set<double> category_query;

  const HomeList({
    super.key,
    required this.job_seekers,
    required this.offers,
    required this.freelancers,
    required this.talents,
    required this.country_query,
    required this.category_query,
  });

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final searchController = TextEditingController();
  int _tab_index = 0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 400.0,
          child: SearchField(
            country_query: widget.country_query,
            category_query: widget.category_query,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
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
                    size: 18.0,
                  ),
                  GetTextField(
                    text: _tab_index == 0
                        ? AppLocalizations.of(context).job
                        : '',
                    light: true,
                    smallSize: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
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
                    size: 18.0,
                  ),
                  GetTextField(
                    text: _tab_index == 1
                        ? AppLocalizations.of(context).offer
                        : '',
                    light: true,
                    smallSize: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
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
                    size: 18.0,
                  ),
                  GetTextField(
                    text: _tab_index == 2
                        ? AppLocalizations.of(context).service 
                        : '',
                    light: true,
                    smallSize: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  _tab_index = 3;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.person_search,
                    color: Colors.white70,
                    size: 18.0,
                  ),
                  GetTextField(
                    text: _tab_index == 3
                        ? AppLocalizations.of(context).talent
                        : '',
                    light: true,
                    smallSize: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Visibility(
          visible: _tab_index == 0,
          child: Expanded(
            child: SharedItems(
              item_index: 0,
              items: parseJobSeekers(widget.job_seekers),
            ),
          ),
        ),
        Visibility(
          visible: _tab_index == 1,
          child: Expanded(
            child: SharedItems(
              item_index: 1,
              items: parseOffers(widget.offers),
            ),
          ),
        ),
        Visibility(
          visible: _tab_index == 2,
          child: Expanded(
            child: SharedItems(
              item_index: 2,
              items: parseFreelancers(widget.freelancers),
            ),
          ),
        ),
        Visibility(
          visible: _tab_index == 3,
          child: Expanded(
            child: SharedItems(
              item_index: 3,
              items: parseTalents(widget.talents),
            ),
          ),
        ),
      ],
    );
  }
}
