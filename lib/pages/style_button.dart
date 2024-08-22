import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_list/themes/theme_provider.dart';
import 'package:video_list/pages/get_text_field.dart';

class StyleButton extends StatefulWidget {
  const StyleButton({super.key});

  @override
  State<StyleButton> createState() => _StyleButtonState();
}

class _StyleButtonState extends State<StyleButton> {
  bool isDarkmode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  setState(() {
                    isDarkmode = !isDarkmode;
                  });
                  isDarkmode
                      ? themeProvider.setDarkmode()
                      : themeProvider.setLightMode();
                },
                child: GetTextField(text: 'Set ${Theme.of(context).brightness == Brightness.light ? 'dark' : 'light'} style'),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
