import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/pages/get_text_field.dart';
import '/pages/home_page.dart';

class SearchField extends StatefulWidget {
  final Set<String> country_query;
  final Set<double> category_query;

  const SearchField({
    super.key,
    required this.country_query,
    required this.category_query,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void setDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Center(
                  child: GetTextField(
                    text: AppLocalizations.of(context).warning,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          widget.category_query.isEmpty
                              ? ListTile(
                                  title: GetTextField(
                                    text:
                                        AppLocalizations.of(context).warning_category,
                                    largeSize: false,
                                  ),
                                  leading: Icon(
                                    Icons.notifications,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                )
                              : SizedBox(),
                          widget.country_query.isEmpty
                              ? ListTile(
                                  title: GetTextField(
                                    text: AppLocalizations.of(context).warning_country,
                                    largeSize: false,
                                  ),
                                  leading: Icon(
                                    Icons.notifications,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding: const EdgeInsets.all(25),
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search",
        contentPadding: EdgeInsets.all(12),
        icon: IconButton(
          onPressed: () => widget.category_query.isNotEmpty &&
                  widget.country_query.isNotEmpty
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      query: '', //searchController.text
                    ),
                  ),
                )
              : {
                  setState(() {
                    setDialog();
                  }),
                },
          icon: const Icon(
            Icons.search,
            color: Colors.amberAccent,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
