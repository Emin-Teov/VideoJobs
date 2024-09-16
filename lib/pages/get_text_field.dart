import 'package:flutter/material.dart';

class GetTextField extends StatefulWidget {
  final String text;
  final bool light;
  final bool largeSize;

  const GetTextField({
    super.key,
    required this.text,
    this.light = false,
    this.largeSize = true,
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
        fontSize: widget.largeSize ? 25 : 14,
        fontStyle: FontStyle.italic,
        color: widget.light
          ? Colors.white70
          : Theme.of(context).textTheme.displayLarge?.color,
      ),
    );
  }
}
