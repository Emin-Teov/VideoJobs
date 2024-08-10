import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/get_text_label.dart';
import 'package:video_list/pages/video_widget.dart';

class VideoItem extends StatefulWidget {
  final int id;
  final String url;
  final String user;
  final String title;
  final bool ceo;
  final String description;

  const VideoItem({
    super.key,
    required this.id,
    required this.url,
    required this.user,
    required this.title,
    required this.ceo,
    required this.description,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool _like_clicked = false;

  void showDescription() {
    showDialog(
      context: context,
      builder: (context) {
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          content: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Center(
                child:  GetTextField(
                  text: 'Description:',
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: size.width,
                  height: size.height / 2,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void showResume() {
    showDialog(
      context: context,
      builder: (context) {
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          content: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close)
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GetTextField(text: widget.user),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.network(
                        'https://emin-teov.github.io/api/resume/cv_resume-${widget.id}.png',
                        width: size.width,
                        height: size.height / 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      width: 50,
                      height: 50,
                      widget.ceo
                          ? 'https://emin-teov.github.io/api/logo/photo-logo-${widget.id}.png'
                          : 'https://emin-teov.github.io/api/profile/profile-image-${widget.id}.png',
                      errorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.blueGrey,
                        );
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: GetTextLabel(
                        head: widget.user,
                        value: widget.title,
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
                        widget.ceo ? IconButton(
                          onPressed: showDescription,
                          icon: Icon(
                            Icons.attach_file,
                            size: 36,
                            color: Colors.amberAccent,
                          ),
                        ): GestureDetector(
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
