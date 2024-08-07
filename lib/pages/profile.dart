import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person),
            GetTextField(text: "Profile",),
          ],
        ),
      ),
    );
  }
}
