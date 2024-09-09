import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class CountryItem extends StatefulWidget {
  final String title;
  final bool value;
  final Function() onBoxChanged;

  const CountryItem({
    super.key,
    required this.title,
    required this.value,
    required this.onBoxChanged,
  });

  @override
  State<CountryItem> createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}