import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class NoInternet extends StatelessWidget {
  final String title;

  const NoInternet({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: GetTextField(text: title, light: true),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_off_outlined),
            GetTextField(text: "No interner"),
          ],
        ),
      ),
    );
  }
}
