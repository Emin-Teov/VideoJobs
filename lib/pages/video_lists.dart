import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:video_list/models/video_model.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/video_list.dart';

Future<List<VideoModel>> fetchVideos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://emin-teov.github.io/api/json/job_seekers.json'));

  return compute(parseVideos, response.body);
}

List<VideoModel> parseVideos(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<VideoModel>((json) => VideoModel.fromJson(json)).toList();
}

class VideoLists extends StatefulWidget {
  const VideoLists({super.key});

  @override
  State<VideoLists> createState() => _VideoListsState();
}

class _VideoListsState extends State<VideoLists> {
  late Future<List<VideoModel>> futureVideos;

  @override
  void initState() {
    super.initState();
    futureVideos = fetchVideos(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<VideoModel>>(
        future: futureVideos,
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
            var size = MediaQuery.of(context).size;
            return Expanded(
              child: GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio:
                        ((size.width / 3) / ((size.height - kToolbarHeight - 24) / 2)),
                    mainAxisSpacing: 124.0,
                    crossAxisSpacing: 0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return VideoList(
                      url: snapshot.data![index].url,
                      data: snapshot.data!.sublist(index, snapshot.data!.length),
                    );
                  }),
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
