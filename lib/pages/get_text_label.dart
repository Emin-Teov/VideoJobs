import 'package:flutter/material.dart';

class GetTextLabel extends StatefulWidget {
  final String head;
  final String value;
  final bool light;
  final bool small;

  const GetTextLabel({
    super.key,
    required this.head,
    required this.value,
    this.light = false,
    this.small = false,
  });

  @override
  State<GetTextLabel> createState() => _GetTextLabelState();
}

class _GetTextLabelState extends State<GetTextLabel> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${widget.head}: ',
        style: TextStyle(
          fontSize: widget.small ? 12.0 : 18.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: widget.light
              ? Colors.white70
              : Theme.of(context).textTheme.displayLarge?.color,
        ),
        children: <TextSpan>[
          TextSpan(
            text: widget.value,
            style: TextStyle(
              fontSize: widget.small ? 14.0 : 20.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: widget.light
                  ? Colors.white70
                  : Theme.of(context).textTheme.displayLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
