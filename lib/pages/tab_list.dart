import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/button_style.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:video_list/pages/get_text_field.dart';

class TabList extends StatefulWidget {
  const TabList({super.key});

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  bool get_remote_context = false;
  List _category_items = [
    'All',
    'Administration, business and management',
    'Financial services',
    'Retail and customer services',
    'Engineering',
    'Computing and ICT',
    'Marketing and advertising, print and publishing',
    'Transport, distribution and logistics',
    'Hospitality, catering and tourism',
    'Education and training',
    'Legal and court services',
    'Facilities and property services',
    'Design, arts and crafts',
    'Healthcare',
    'Construction and building',
    'Security, uniformed and protective services',
    'Science, mathematics and statistics',
    'Manufacturing and production',
  ];
  List _countries = [
    'All',
    'Azerbaijan',
    'Georgia',
    'Iran',
    'Kazakhstan',
    'Kyrgyzstan',
    'Turkey',
    'Uzbekistan',
  ];

  void showCategories() {
    showDialog(
      context: context,
      builder: (context) {
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
                  child: Container(
                  width: 450,
                  height: 550,
                  child: ListView.builder(
                    itemCount: _category_items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Checkbox(value: true, onChanged: null),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              child: GetTextField(text: _category_items[index]),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void showCountries() {
    showDialog(
      context: context,
      builder: (context) {
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
                  child: Container(
                  width: 450,
                  height: 550,
                  child: ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Checkbox(value: true, onChanged: null),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              child: GetTextField(text: _countries[index]),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(top: 85.0),
          child: GetTextField(text: "Job types"),
        ),
        SizedBox(
          width: 300,
          child: GradientElevatedButton(
            onPressed: () {
              setState(() {
                get_remote_context = !get_remote_context;
              });
            },
            style: GradientButtonStyle(
              gradient: LinearGradient(
                colors: get_remote_context
                    ? [
                        Colors.cyanAccent,
                        Colors.blueGrey,
                      ]
                    : [
                        Colors.blueGrey,
                        Colors.cyanAccent,
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: GetTextField(
                text: get_remote_context ? "Remote Job" : "Local Job"),
          ),
        ),
        SizedBox(
          width: 300,
          child: GradientElevatedButton(
            onPressed: showCategories,
            style: GradientButtonStyle(
              gradient: LinearGradient(
                colors: [Colors.cyanAccent, Colors.blueGrey,],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: GetTextField(text: "Job Categories"),
          ),
        ),
        SizedBox(
          width: 300,
          child: GradientElevatedButton(
            onPressed: showCountries,
            style: GradientButtonStyle(
              gradient: LinearGradient(
                colors: [Colors.cyanAccent, Colors.blueGrey,],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: GetTextField(text: "Select Countries"),
          ),
        ),
      ],
    );
  }
}
