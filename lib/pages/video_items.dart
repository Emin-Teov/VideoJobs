import 'package:flutter/material.dart';
import 'package:video_list/pages/video_item.dart';

class VideoItems extends StatefulWidget {
  const VideoItems({super.key});

  @override
  State<VideoItems> createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  final List _video_items = [
    [
      0,
      "https://videos.pexels.com/video-files/4994033/4994033-uhd_2560_1440_25fps.mp4",
      "Check Martin",
      "Graphics Designer"
    ],
    [
      0,
      "https://videos.pexels.com/video-files/4962719/4962719-uhd_2560_1440_25fps.mp4",
      "Anna Ova",
      "IT Developer"
    ],
    [
      0,
      "https://videos.pexels.com/video-files/4962731/4962731-uhd_2560_1440_25fps.mp4",
      "Irina Sena",
      "Engineer"
    ],
    [
      0,
      "https://videos.pexels.com/video-files/3253737/3253737-uhd_2560_1440_25fps.mp4",
      "Antony Carters",
      "Manager"
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(
          width: 400,
          child: TextField(
            scrollPadding: EdgeInsets.all(25),
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: EdgeInsets.all(12),
              icon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: _video_items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: VideoItem(
                      id: _video_items[index][0],
                      url: _video_items[index][1],
                      username: _video_items[index][2],
                      title: _video_items[index][3],
                    ),
                  );
                }))
      ],
    );
  }
}
