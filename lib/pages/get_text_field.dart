import 'package:flutter/material.dart';

class GetTextField extends StatefulWidget {
  final String text;
  final bool light;

  const GetTextField({
    super.key, 
    required this.text, 
    this.light = false,
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
        fontSize: 25,
        fontStyle: FontStyle.italic,
        color: widget.light ? Colors.white70 : Theme.of(context).textTheme.displayLarge?.color,
      ),
    );
  }
}
