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
  bool _is_clicked = false;
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
                    setState(() {
                      _is_clicked = !_is_clicked;
                    });
                  },
                  child: GetTextField(text: 'Set style')),
            ),
          ],
        ),
        _is_clicked
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: _is_clicked ? 24.0 : 0),
                    child: TextButton(
                      onPressed: () {
                        final themeProvider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        setState(() {
                          isDarkmode = !isDarkmode;
                        });
                        isDarkmode
                            ? themeProvider.setDarkmode()
                            : themeProvider.setLightMode();
                      },
                      child: Text(
                        Theme.of(context).brightness == Brightness.light ? 'Get dark mode' : 'Get light mode',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black87
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(width: 0, height: 0),
        Divider(),
      ],
    );
  }
}
