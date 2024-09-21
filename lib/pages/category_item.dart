import 'package:flutter/material.dart';
import '/pages/get_text_field.dart';

// typedef OnChangeFunc = void Function(int index);

class CategoryItem extends StatefulWidget {
  final int index;
  final String title;
  final bool value;
  final Function() onBoxChanged;

  const CategoryItem({
    super.key,
    required this.index,
    required this.title,
    required this.value,
    required this.onBoxChanged,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                          }),
                        })
              ],
            ),
            Expanded(
              child: SizedBox(
                child: GetTextField(text: widget.title, smallSize: true,),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
