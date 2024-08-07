import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/button_style.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:video_list/pages/category_items.dart';
import 'package:video_list/pages/country_items.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:public_ip_address/public_ip_address.dart';

Future<String> getCountryIp() async {
  String country = await IpAddress().getCountryCode();
  return country;
}

class TabList extends StatefulWidget {
  const TabList({super.key});

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  bool get_remote_context = false;
  late Future<String> getCountry;

  @override
  void initState() {
    super.initState();
    getCountry = getCountryIp();
  }

  void setDialog(bool category) {
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
                        icon: Icon(Icons.close)),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder<String>(
                    future: getCountry,
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
                        return Container(
                          width: 450,
                          height: 550,
                          child: category ? CategoryItems() : CountryItems(code: snaps.data!),
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
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(top: 85.0),
          child: GetTextField(
            text: "Job types",
            light: true,
          ),
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
              text: get_remote_context ? "Freelancer" : "Local Job",
              light: true,
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: GradientElevatedButton(
            onPressed: () => setDialog(true),
            style: GradientButtonStyle(
              gradient: LinearGradient(
                colors: [
                  Colors.cyanAccent,
                  Colors.blueGrey,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: GetTextField(
              text: "Job Categories",
              light: true,
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: GradientElevatedButton(
            onPressed: () => setDialog(false),
            style: GradientButtonStyle(
              gradient: LinearGradient(
                colors: [
                  Colors.cyanAccent,
                  Colors.blueGrey,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: GetTextField(
              text: "Select Countries",
              light: true,
            ),
          ),
        ),
      ],
    );
  }
}
