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

class TypeTab extends StatefulWidget {
  final List categories;
  final List countries;
  final String country_code;

  const TypeTab({
    super.key,
    required this.categories,
    required this.countries,
    required this.country_code
  });

  @override
  State<TypeTab> createState() => _TypeTabState();
}

class _TypeTabState extends State<TypeTab> {
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
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? size.height * 0.75 : size.height / 2,
                  child: category
                  ? CategoryItems(
                      items: categories,
                    )
                  : CountryItems(
                      items: countries,
                      code: widget.country_code,
                    ),
                ),
              ),
              SizedBox.shrink(),
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
          padding: EdgeInsets.only(top: 100.0),
          child: GetTextField(
            text: "Set Job types",
            light: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
          child: SizedBox(
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
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
          child: SizedBox(
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
        ),
      ],
    );
  }
}
