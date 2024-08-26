import 'package:flutter/material.dart';

class GetTextField extends StatefulWidget {
  final String text;
  final bool light;
  final bool setLargeSize;

  const GetTextField({
    super.key,
    required this.text,
    this.light = false,
    this.setLargeSize = true,
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
        fontSize: widget.setLargeSize ? 25 : 14,
        fontStyle: FontStyle.italic,
        color: widget.light
          ? Colors.white70
          : Theme.of(context).textTheme.displayLarge?.color,
      ),
    );
  }
}
