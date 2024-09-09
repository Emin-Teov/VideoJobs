import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class SubCategoryItem extends StatefulWidget {
  final int index;
  final String title;
  final bool value;
  final Function() onBoxChanged;

  const SubCategoryItem({
    super.key,
    required this.index,
    required this.title,
    required this.value,
    required this.onBoxChanged,
  });

  @override
  State<SubCategoryItem> createState() => _SubCategoryItemState();
}

class _SubCategoryItemState extends State<SubCategoryItem> {
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
                value: widget.value,
                onChanged: (value) => {
                  setState(() {
                    widget.onBoxChanged();
                  }),
                }
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
    );
  }
}
