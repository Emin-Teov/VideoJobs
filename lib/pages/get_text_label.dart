import 'package:flutter/material.dart';

class GetTextLabel extends StatefulWidget {
  final String head;
  final String value;

  const GetTextLabel({
    super.key,
    required this.head,
    required this.value
  });

  @override
  State<GetTextLabel> createState() => _GetTextLabelState();
}

class _GetTextLabelState extends State<GetTextLabel> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$widget.head: ',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: widget.value,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
