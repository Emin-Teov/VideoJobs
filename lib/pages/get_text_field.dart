import 'package:flutter/material.dart';

class GetTextField extends StatefulWidget {
  final String text;

  const GetTextField({super.key, required this.text});

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
        color: Colors.white,
      ),
    );
  }
}
