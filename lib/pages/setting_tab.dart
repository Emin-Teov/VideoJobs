import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/themes/theme_provider.dart';
import '/pages/get_text_field.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  bool _is_clicked_style_button = false;

  @override
  Widget build(BuildContext context) {
    bool _is_darkmode  = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(top: 100.0),
          child: GetTextField(
            text: AppLocalizations.of(context).settings,
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
                    text: AppLocalizations.of(context).style, light: true),
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
                    padding: EdgeInsets.only(left: 24.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<ThemeProvider>(context, listen: false).setStyle(_is_darkmode);
                        });
                      },
                      child: GetTextField(
                        text: AppLocalizations.of(context).change(_is_darkmode ? 0 : 1),
                        largeSize: false,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {});
              },
              child: GetTextField(
                text: 'Set language',
                light: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
