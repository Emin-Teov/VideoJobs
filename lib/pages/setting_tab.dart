import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/settrings/settrings_provider.dart';
import '/pages/get_text_field.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  bool _is_clicked_style_button = false;
  bool _is_clicked_lang_button = false;
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<SettringsProvider>(context, listen: false);
    bool isDarkmode = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                      _is_clicked_lang_button = false;
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
                            _provider.setStyle(isDarkmode);
                          });
                        },
                        child: GetTextField(
                          text: AppLocalizations.of(context)
                              .change(isDarkmode ? 0 : 1),
                          smallSize: true,
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
            children: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    _is_clicked_lang_button = !_is_clicked_lang_button;
                    _is_clicked_style_button = false;
                  });
                },
                child: GetTextField(
                  text: AppLocalizations.of(context).language,
                  light: true,
                ),
              ),
            ],
          ),
          _is_clicked_lang_button
              ? SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _provider.languages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        width: 50,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _provider.setLang(index);
                            });
                          },
                          child: GetTextField(
                            text: _provider.languages[index],
                            smallSize: true,
                            underline: _provider.languages[index] == _provider.language,
                          ),
                        ),
                      );
                    }
                  ),
                )
              : SizedBox.shrink(),
          Divider(),
        ],
      ),
    );
  }
}
