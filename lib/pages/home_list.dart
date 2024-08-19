import 'package:flutter/material.dart';

import 'package:video_list/models/job_seeker_model.dart';
import 'package:video_list/models/offer_model.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/offer_items.dart';
import 'package:video_list/pages/job_seeker_items.dart';

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

class HomeList extends StatefulWidget {
  final List job_seekers;
  final List offers;

  const HomeList({
    super.key,
    required this.job_seekers,
    required this.offers
  });

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  bool _set_job_seekers_list = true;
  late List<JobSeekerModel> job_seekers;
  late List<OfferModel> offers;

  @override
  void initState() {
    super.initState();

    job_seekers = parseJobSeekers(widget.job_seekers);
    offers = parseOffers(widget.offers);
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  _set_job_seekers_list = true;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.person_pin_rounded,
                    color: Colors.white,
                  ),
                  GetTextField(
                    text: 'I need job',
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
                  _set_job_seekers_list = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.local_offer,
                    color: Colors.white,
                  ),
                  GetTextField(
                    text: 'Job offers',
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
          child: _set_job_seekers_list ? JobSeekerItems(items: job_seekers,) : OfferItems(items: offers,),
        ),
      ],
    );
  }
}
