import 'package:flutter/material.dart';

import 'package:video_list/models/category_model.dart';
import 'package:video_list/pages/category_item.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/sub_category_items.dart';

class CategoryItems extends StatefulWidget {
  final int count;
  final Set<double> codes;
  final List<CategoryModel> items;

  const CategoryItems({
    super.key,
    required this.count,
    required this.codes,
    required this.items,
  });

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  void _set_categories() {
    setState(() {
      if (widget.codes.length == widget.count) {
        widget.codes.clear();
      } else {
        for (CategoryModel category in widget.items) {
          if (category.children.isEmpty) {
            widget.codes.add(category.number);
          } else {
            for (var category_sub_data in category.children) {
              CategoryModel sub_category = CategoryModel.fromJson(category_sub_data);
              widget.codes.add(sub_category.number);
            }
          }
        }
      }
    });
  }

  void _set_category(double index) {
    setState(() {
      widget.codes.contains(index)
          ? widget.codes.remove(index)
          : widget.codes.add(index);
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
                    value: widget.codes.length == widget.count,
                    onChanged: (value) => _set_categories(),
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
                          value: widget.codes.contains(widget.items[index].number),
                          onBoxChanged: () => _set_category(widget.items[index].number),
                        )
                      : SubCategoryItems(
                          index: widget.items[index].index,
                          title: widget.items[index].title,
                          number: widget.items[index].number,
                          onBoxChanged: _set_category,
                          codes: widget.codes,
                          data: widget.items[index].children,
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
