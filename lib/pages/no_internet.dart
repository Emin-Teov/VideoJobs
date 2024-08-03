import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_off_outlined),
          GetTextField(text: "No interner"),
        ],
      )
      
    );
  }
}

