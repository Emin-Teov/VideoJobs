import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_list/themes/theme_provider.dart';
import 'package:video_list/pages/get_text_field.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  bool _is_darkmode = false;
  bool _is_clicked_style_button = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(top: 100.0),
          child: GetTextField(
            text: "Settings",
            light: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _is_clicked_style_button = !_is_clicked_style_button;
                  });
                },
                child: GetTextField(
                    text: 'Set style',
                    light: true),
              ),
            ),
          ],
        ),
        _is_clicked_style_button
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: TextButton(
                  onPressed: () {
                    final themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    setState(() {
                      _is_darkmode = !_is_darkmode;
                    });
                    _is_darkmode
                        ? themeProvider.setDarkmode()
                        : themeProvider.setLightMode();
                  },
                  child: Text(
                    'Get ${Theme.of(context).brightness == Brightness.light ? 'dark' : 'light'} style',
                  ),
                ),
              ),
            ],
          )
        : SizedBox.shrink(),
        Divider(),
      ],
    );
  }
}
