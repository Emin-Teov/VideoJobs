import 'package:flutter/material.dart';
import 'package:video_list/pages/style_button.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StyleButton(),
          ],
        ),
      ),
    );
  }
}
