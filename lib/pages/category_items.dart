import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/category_model.dart';
import '/pages/category_item.dart';
import '/pages/get_text_field.dart';
import '/pages/sub_category_items.dart';

class CategoryItems extends StatefulWidget {
  final Set<double> codes;
  final List<CategoryModel> items;

  const CategoryItems({
    super.key,
    required this.codes,
    required this.items,
  });

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  late int count;

  @override
  void initState() {
    super.initState();

    count = widget.codes.length;
  }

  void _set_categories() {
    setState(() {
      if (widget.codes.length == count) {
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

  bool _sub_categories(int number, int length) {
    int result = 0;
    widget.codes.forEach((e) {
      if (e.toInt() == number) result++;
    });
    return result == length;
  }

  void _set_sub_categories(double number, List<CategoryModel> data) {
    setState(() {
      bool remove = _sub_categories(number.toInt(), data.length);
      for (CategoryModel sub_category in data) remove
          ? widget.codes.remove(sub_category.number)
          : widget.codes.add(sub_category.number);
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
                    value: widget.codes.length == count,
                    onChanged: (value) => _set_categories(),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: GetTextField(text: AppLocalizations.of(context).all),
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
                          title: AppLocalizations.of(context).categories(widget.items[index].code),
                          value: widget.codes.contains(widget.items[index].number),
                          onBoxChanged: () => _set_category(widget.items[index].number),
                        )
                      : SubCategoryItems(
                          index: widget.items[index].index,
                          title: AppLocalizations.of(context).categories(widget.items[index].code),
                          number: widget.items[index].number,
                          value: _sub_categories(
                              widget.items[index].number.toInt(),
                              widget.items[index].children.length),
                          onBoxesChanged: _set_sub_categories,
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
