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
  final double number;
  final Function(double) onBoxChanged;
  final Set<double> codes;
  final List data;

  const SubCategoryItems({
    super.key,
    required this.index,
    required this.title,
    required this.number,
    required this.onBoxChanged,
    required this.codes,
    required this.data,
  });

  @override
  State<SubCategoryItems> createState() => _SubCategoryItemsState();
}

class _SubCategoryItemsState extends State<SubCategoryItems> {
  late List<CategoryModel> _sub_categories;
  @override
  void initState() {
    super.initState();
    _sub_categories = parseSubCategories(widget.data);
  }

  Widget build(BuildContext context) {
    bool _check_sub_categories() {
      int count = 0;
      widget.codes.forEach((e) {
        if (e.toInt() == widget.number.toInt()) count++;
      });
      return count == widget.data.length;
    }

    void _change_sub_categories(bool remove) {
      setState(() {
        for (CategoryModel _sub_category in _sub_categories) 
          remove ? widget.codes.remove(_sub_category.number) : widget.codes.add(_sub_category.number);
      });
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
                    value: _check_sub_categories(),
                    onChanged: (value) => _change_sub_categories(_check_sub_categories()),
                  ),
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
                value: widget.codes.contains(_sub_categories[index].number),
                onBoxChanged: () =>
                    widget.onBoxChanged(_sub_categories[index].number),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
