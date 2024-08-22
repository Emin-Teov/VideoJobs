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
  final bool selected;
  final List data;

  const SubCategoryItems({
    super.key,
    required this.index,
    required this.title,
    required this.selected,
    required this.data,
  });

  @override
  State<SubCategoryItems> createState() => _SubCategoryItemsState();
}

class _SubCategoryItemsState extends State<SubCategoryItems> {
  late bool onBoxChanged = true;

  late List<CategoryModel> _sub_categories;

  @override
  void initState() {
    super.initState();
    _sub_categories = parseSubCategories(widget.data);
  }

  Widget build(BuildContext context) {
    return  Expanded(
      // margin: EdgeInsets.all(10.0),
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
                    value: onBoxChanged ? widget.selected : !widget.selected,
                    onChanged: (value) => setState(() {
                      onBoxChanged = !onBoxChanged;
                    }),
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
                selected: onBoxChanged ? widget.selected : !widget.selected,
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
