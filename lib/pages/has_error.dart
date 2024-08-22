import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';

class HasError extends StatelessWidget {
  final String title;
  final bool no_internet;

  const HasError({
    super.key,
    required this.title,
    required this.no_internet,
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
          children: <Widget>[
            Icon(no_internet ? Icons.signal_wifi_off_outlined : Icons.error),
            GetTextField(text: no_internet ? 'No interner' : 'An error has occurred!'),
          ],
        ),
      ),
    );
  }
}
