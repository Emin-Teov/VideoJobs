import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/get_text_label.dart';
import 'package:video_list/pages/video_widget.dart';

class VideoItem extends StatefulWidget {
  final String url;
  final String name;
  final String surname;
  final String title;

  const VideoItem(
      {super.key,
      required this.url,
      required this.name,
      required this.surname,
      required this.title});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool _like_clicked = false;

  void showResume() {
    showDialog(
        context: context,
        builder: (context) {
          var size = MediaQuery.of(context).size.width;
          return AlertDialog(
            content: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close)),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GetTextField(text: '${widget.name} ${widget.surname}'),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.network(
                          'https://emin-teov.github.io/api/resume/cv_resume-0.png',
                          width: size,
                          height: size,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void liked() {
    setState(() {
      _like_clicked = !_like_clicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoWidget(url: widget.url),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2),
                      child: GetTextLabel(
                        head: widget.title,
                        value: '${widget.name} ${widget.surname}',
                        ligth: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: liked,
                          icon: Icon(
                            Icons.handshake,
                            size: 36,
                            color: _like_clicked ? Colors.red : Colors.blueGrey,
                          ),
                        ),
                        GestureDetector(
                          onTap: showResume,
                          child: ImageIcon(
                            AssetImage("assets/icons/cv.png"),
                            color: Colors.amberAccent,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
