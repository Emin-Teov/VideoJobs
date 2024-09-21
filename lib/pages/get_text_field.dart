import 'package:flutter/material.dart';

class GetTextField extends StatefulWidget {
  final String text;
  final bool smallSize;
  final bool light;
  final bool overline;

  const GetTextField({
    super.key,
    required this.text,
    this.smallSize = false,
    this.light = false,
    this.overline = false,
  });

  @override
  State<GetTextField> createState() => _GetTextFieldState();
}

class _GetTextFieldState extends State<GetTextField> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.smallSize ? 14 : 25,
        decoration: widget.overline ? TextDecoration.overline : null,
        fontStyle: FontStyle.italic,
        color: widget.light
            ? Colors.white70
            : Theme.of(context).textTheme.displayLarge?.color,
      ),
    );
  }
}
