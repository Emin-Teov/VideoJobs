import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';

import 'package:video_list/models/job_seeker_model.dart';
import 'package:video_list/models/offer_model.dart';
import 'package:video_list/models/freelancer_model.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/shared_items.dart';

Future<List<Uint8List>> getThumbnailImage(
    List<dynamic> responseBody, int index) async {
  List<String> url = ['job_seeker', 'job_offer', 'freelancer'];
  List<Uint8List> thumbnails = [];
  for (final response in responseBody) {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: 'https://emin-teov.github.io/api/video/${url[index]}_${response.id}.mp4',
      imageFormat: ImageFormat.PNG
    );
    thumbnails.add(thumbnail);
  }
  return thumbnails;
}

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

  const HomeList(
      {super.key,
      required this.job_seekers,
      required this.offers,
      required this.freelancers});

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  int _tab_index = 0;

  late List<JobSeekerModel> job_seekers;
  late List<OfferModel> offers;
  late List<FreelancerModel> freelancers;

  @override
  void initState() {
    super.initState();

    job_seekers = parseJobSeekers(widget.job_seekers);
    offers = parseOffers(widget.offers);
    freelancers = parseFreelancers(widget.freelancers);
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
          child: FutureBuilder<List>(
            future: Future.wait([
              getThumbnailImage(job_seekers, 0),
              getThumbnailImage(offers, 1),
              getThumbnailImage(freelancers, 2),
            ]),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.error),
                      GetTextField(
                        text: "An error has occurred!",
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                return SharedItems(
                  item_index: _tab_index,
                  job_seekers: job_seekers,
                  offers: offers,
                  freelancers: freelancers,
                  getThumbnailsJobSeekers: snapshot.data![0],
                  getThumbnailsOffers: snapshot.data![1],
                  getThumbnailsFreelancers: snapshot.data![2]
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
