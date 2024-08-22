import 'package:flutter/material.dart';

import 'package:video_list/models/country_model.dart';
import 'package:video_list/pages/country_item.dart';
import 'package:video_list/pages/get_text_field.dart';

class CountryItems extends StatefulWidget {
  final List<CountryModel> items;
  final String code;

  const CountryItems({
    super.key,
    required this.items,
    required this.code,
  });

  @override
  State<CountryItems> createState() => _CountryItemsState();
}

class _CountryItemsState extends State<CountryItems> {
  late Future<List<CountryModel>> futureCountries;
  late Future<String> getCountry;
  bool _set_items = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
                          }),
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
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: CountryItem(
                      title: widget.items[index].title,
                      located: (widget.items[index].code != widget.code),
                      selected: _set_items,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
