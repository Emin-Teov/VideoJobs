import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/button_style.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/category_model.dart';
import '/models/country_model.dart';
import '/pages/category_items.dart';
import '/pages/country_items.dart';
import '/pages/get_text_field.dart';

class TypeTab extends StatefulWidget {
  final List<CategoryModel> categories;
  final List<CountryModel> countries;
  final Set<String> country_codes;
  final Set<double> category_codes;

  const TypeTab({
    super.key,
    required this.categories,
    required this.countries,
    required this.country_codes,
    required this.category_codes,
  });

  @override
  State<TypeTab> createState() => _TypeTabState();
}

class _TypeTabState extends State<TypeTab> {
  void setDialog(bool category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Size size = MediaQuery.of(context).size;
            return AlertDialog(
              surfaceTintColor: Colors.transparent,
              actionsPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              insetPadding: EdgeInsets.all(8.0),
              contentPadding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * .8,
                        height: MediaQuery.of(context).orientation == Orientation.portrait
                            ? size.height * .7
                            : size.height / 2,
                        child: category
                            ? CategoryItems(
                                codes: widget.category_codes,
                                items: widget.categories,
                              )
                            : CountryItems(
                                codes: widget.country_codes,
                                items: widget.countries,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(top: 100.0),
          child: GetTextField(
            text: AppLocalizations.of(context).search,
            light: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
          child: SizedBox(
            width: 300,
            child: GradientElevatedButton(
              onPressed: () => setDialog(true),
              style: GradientButtonStyle(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent,
                    Colors.blueGrey,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: GetTextField(
                text: AppLocalizations.of(context).select_type,
                light: true,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
          child: SizedBox(
            width: 300,
            child: GradientElevatedButton(
              onPressed: () => setDialog(false),
              style: GradientButtonStyle(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent,
                    Colors.blueGrey,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: GetTextField(
                text: AppLocalizations.of(context).select_country,
                light: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
