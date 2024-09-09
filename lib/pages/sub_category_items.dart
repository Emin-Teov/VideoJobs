import 'package:flutter/material.dart';
import 'package:video_list/models/category_model.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/sub_category_item.dart';

List<CategoryModel> parseSubCategories(List<dynamic> responseBody) {
  List<CategoryModel> parsed = [];
  for (dynamic body in responseBody) {
    parsed.add(CategoryModel.fromJson(body));
  }
  return parsed;
}

class SubCategoryItems extends StatefulWidget {
  final int index;
  final String title;
  final bool value;
  final Function() onBoxChanged;
  final List data;

  const SubCategoryItems({
    super.key,
    required this.index,
    required this.title,
    required this.value,
    required this.onBoxChanged,
    required this.data,
  });

  @override
  State<SubCategoryItems> createState() => _SubCategoryItemsState();
}

class _SubCategoryItemsState extends State<SubCategoryItems> {
  late List<CategoryModel> _sub_categories;
  late List<bool> _set_sub_items;
  late bool _check_list;

  @override
  void initState() {
    super.initState();
    _sub_categories = parseSubCategories(widget.data);
    _set_sub_items = List.filled(widget.data.length, widget.value);
    _check_list = widget.value;
  }

  void _set_sub_categories(int index) {
    setState(() {
      _set_sub_items[index] = !_set_sub_items[index];
      if ((_set_sub_items.contains(false) && widget.value) ||
          (!_set_sub_items.contains(false) && !widget.value)) {
        widget.onBoxChanged();
      }
    });
  }

  Widget build(BuildContext context) {
    if (_check_list != widget.value) {
      _set_sub_items = List.filled(widget.data.length, widget.value);
      _check_list = widget.value;
    }
    return Expanded(
      child: Column(
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
                      value: widget.value,
                      onChanged: (value) => {
                            setState(() {
                              widget.onBoxChanged();
                              if (!widget.value) {
                                _set_sub_items =
                                    List.filled(widget.data.length, true);
                              } else {
                                _set_sub_items =
                                    List.filled(widget.data.length, false);
                              }
                            }),
                          }),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: GetTextField(text: widget.title),
                ),
              ),
            ],
          ),
          Divider(),
          ListView.builder(
            itemCount: _sub_categories.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SubCategoryItem(
                index: _sub_categories[index].index,
                title: _sub_categories[index].title,
                value: _set_sub_items[index],
                onBoxChanged: () => _set_sub_categories(index),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
