import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/category_model.dart';
import '/pages/get_text_field.dart';
import '/pages/sub_category_item.dart';

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
  final bool value;
  final Function(double, List<CategoryModel>) onBoxesChanged;
  final Function(double) onBoxChanged;
  final Set<double> codes;
  final List data;

  const SubCategoryItems({
    super.key,
    required this.index,
    required this.title,
    required this.number,
    required this.value,
    required this.onBoxesChanged,
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
                    onChanged: (value) => widget.onBoxesChanged(widget.number, _sub_categories),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: GetTextField(
                    text: widget.title,
                    largeSize: false,
                  ),
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
                title: AppLocalizations.of(context)
                    .categories(_sub_categories[index].code),
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
