import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/offer_items.dart';
import 'package:video_list/pages/video_lists.dart';

class HomeList extends StatefulWidget {
  const HomeList({super.key});

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  bool _set_video_list = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  _set_video_list = true;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.person_pin_rounded,
                    color: Colors.white,
                  ),
                  GetTextField(text: 'Job seekers', light: true,),
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
                  _set_video_list = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.local_offer,
                    color: Colors.white,
                  ),
                  GetTextField(text: 'Job offers', light: true,),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: _set_video_list ? VideoLists() : OfferItems(),
        ),
      ],
    );
  }
}
