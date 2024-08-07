import 'package:flutter/material.dart';
import 'package:video_list/models/category_model.dart';
import 'package:video_list/pages/category_item.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:video_list/pages/sub_category_items.dart';

Future<List<CategoryModel>> fetchCategories(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://emin-teov.github.io/api/json/categories.json'));

  return compute(parseCategories, response.body);
}

List<CategoryModel> parseCategories(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed
      .map<CategoryModel>((json) => CategoryModel.fromJson(json))
      .toList();
}

class CategoryItems extends StatefulWidget {
  const CategoryItems({
    super.key,
  });

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  late Future<List<CategoryModel>> futureCategories;
  bool _set_items = true;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CategoryModel>>(
        future: futureCategories,
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
                      itemCount: snaps.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: snaps.data![index].children.isEmpty ? CategoryItem(
                            index: snaps.data![index].index,
                            title: snaps.data![index].title,
                            selected: _set_items,
                          ) : SubCategoryItems(
                            index: snaps.data![index].index,
                            title: snaps.data![index].title,
                            selected: _set_items,
                            data: snaps.data![index].children
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
