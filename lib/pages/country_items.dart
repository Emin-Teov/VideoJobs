import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:video_list/models/country_model.dart';
import 'package:video_list/pages/country_item.dart';
import 'package:video_list/pages/get_text_field.dart';

Future<List<CountryModel>> fetchCountries(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://emin-teov.github.io/api/json/countries.json'));
  return compute(parseCountries, response.body);
}

List<CountryModel> parseCountries(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed
      .map<CountryModel>((json) => CountryModel.fromJson(json))
      .toList();
}

class CountryItems extends StatefulWidget {
  final String code;

  const CountryItems({
    super.key,
    required this.code,
  });

  @override
  State<CountryItems> createState() => _CountryItemsState();
}

class _CountryItemsState extends State<CountryItems> {
  late Future<List<CountryModel>> futureCountries;
  bool _set_items = false;

  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountries(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CountryModel>>(
        future: futureCountries,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Checkbox(
                          value: _set_items,
                          onChanged: (value) => {
                            setState(() {
                              _set_items = !_set_items;
                            })
                          }
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        child: GetTextField(text: 'All'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: CountryItem(
                            title: snapshot.data![index].title,
                            located: (snapshot.data![index].code != widget.code),
                            selected: _set_items,
                          ),
                        );
                      }),
                ),
              ],
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
