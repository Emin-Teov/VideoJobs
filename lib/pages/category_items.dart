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
  late List<bool> _set_items;

  @override
  void initState() {
    super.initState();
    _set_items = List.filled(widget.items.length, true);
  }

  void _set_categories(int index) {
    setState(() {
      _set_items[index] = !_set_items[index];
    });
  }

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
                    value: !_set_items.contains(false),
                    onChanged: (value) => {
                      setState(() {
                        _set_items = List.filled(widget.items.length, _set_items.contains(false) ? true : false);
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
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: widget.items[index].children.isEmpty
                        ? CategoryItem(
                            index: widget.items[index].index,
                            title: widget.items[index].title,
                            value: _set_items[index],
                            onBoxChanged: () => _set_categories(index),
                          )
                        : SubCategoryItems(
                            index: widget.items[index].index,
                            title: widget.items[index].title,
                            value: _set_items[index],
                            onBoxChanged: () => _set_categories(index),
                            data: widget.items[index].children
                          ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
