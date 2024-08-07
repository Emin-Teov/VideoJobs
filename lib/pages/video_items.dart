import 'package:flutter/material.dart';
import 'package:video_list/models/video_model.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/video_item.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

class VideoItems extends StatefulWidget {
  const VideoItems({super.key});

  @override
  State<VideoItems> createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
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
        builder: (context, snaps) {
          if (snaps.hasError) {
            return const Center(
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
          } else if (snaps.hasData) {
            return Expanded(
              child: ListView.builder(
                itemCount: snaps.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: VideoItem(
                      id: snaps.data![index].id,
                      url: snaps.data![index].url,
                      username: snaps.data![index].name + ' ' +snaps.data![index].surname,
                      title: snaps.data![index].title,
                    ),
                  );
                }
              ),
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
