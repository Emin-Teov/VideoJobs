import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class SubCategoryItem extends StatefulWidget {
  final int index;
  final String title;
  final bool selected;

  const SubCategoryItem({
    super.key,
    required this.index,
    required this.title,
    required this.selected,
  });

  @override
  State<SubCategoryItem> createState() => _SubCategoryItemState();
}

class _SubCategoryItemState extends State<SubCategoryItem> {
  late bool onBoxChanged = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Checkbox(
                  value: onBoxChanged ? widget.selected : !widget.selected,
                  onChanged: (value) => {
                        setState(() {
                          onBoxChanged = !onBoxChanged;
                        })
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
    );
  }
}
