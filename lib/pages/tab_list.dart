import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/button_style.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

import 'package:video_list/models/category_model.dart';
import 'package:video_list/models/country_model.dart';
import 'package:video_list/pages/category_items.dart';
import 'package:video_list/pages/country_items.dart';
import 'package:video_list/pages/get_text_field.dart';

List<CategoryModel> parseCategories(List<dynamic> responseBody) {
  List<CategoryModel> parsed = [];
  for (dynamic body in responseBody) {
    parsed.add(CategoryModel.fromJson(body));
  }
  return parsed;
}

List<CountryModel> parseCountries(List<dynamic> responseBody) {
  List<CountryModel> parsed = [];
  for (dynamic body in responseBody) {
    parsed.add(CountryModel.fromJson(body));
  }
  return parsed;
}

class TabList extends StatefulWidget {
  final List categories;
  final List countries;

  const TabList({super.key, required this.categories, required this.countries});

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  bool get_remote_context = false;
  late List<CategoryModel> categories;
  late List<CountryModel> countries;

  @override
  void initState() {
    super.initState();

    categories = parseCategories(widget.categories);
    countries = parseCountries(widget.countries);
  }

  void setDialog(bool category) {
    showDialog(
        context: context,
        builder: (context) {
          var size = MediaQuery.of(context).size;
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close)),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height / 2,
                    child: category
                        ? CategoryItems(
                            items: categories,
                          )
                        : CountryItems(
                          items: countries,
                        ),
                  ),
                ),
                SizedBox(),
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
              text: get_remote_context ? "Service" : "Local Job",
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
              text: "Countries",
              light: true,
            ),
          ),
        ),
      ],
    );
  }
}
