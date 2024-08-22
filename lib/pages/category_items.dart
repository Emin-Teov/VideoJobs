import 'package:flutter/material.dart';
import 'package:video_list/models/category_model.dart';
import 'package:video_list/pages/category_item.dart';
import 'package:video_list/pages/get_text_field.dart';

import 'package:video_list/pages/sub_category_items.dart';

class CategoryItems extends StatefulWidget {
  final List<CategoryModel> items;
  
  const CategoryItems({
    super.key,
    required this.items,
  });

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  late Future<List<CategoryModel>> futureCategories;
  bool _set_items = true;

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
                  child: widget.items[index].children.isEmpty
                    ? CategoryItem(
                        index: widget.items[index].index,
                        title: widget.items[index].title,
                        selected: _set_items,
                      )
                    : SubCategoryItems(
                        index: widget.items[index].index,
                        title: widget.items[index].title,
                        selected: _set_items,
                        data: widget.items[index].children
                      ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
