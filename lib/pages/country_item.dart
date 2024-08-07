import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class CountryItem extends StatefulWidget {
  final String title;
  final bool located;
  final bool selected;

  const CountryItem({
    super.key,
    required this.title,
    required this.located,
    required this.selected,
  });

  @override
  State<CountryItem> createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  late bool onBoxChanged;
  
  @override
  void initState() {
    super.initState();
    onBoxChanged = widget.located;
  }

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
    );
  }
}
