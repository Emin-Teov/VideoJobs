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
                  Center(
                    child: GetTextField(
                      text: AppLocalizations.of(context).warning,
                    ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            widget.category_query.isEmpty
                                ? ListTile(
                                    title: GetTextField(
                                      text: AppLocalizations.of(context)
                                          .warning_category,
                                      smallSize: true,
                                    ),
                                    leading: Icon(
                                      Icons.notifications,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                  )
                                : SizedBox.shrink(),
                            widget.country_query.isEmpty
                                ? ListTile(
                                    title: GetTextField(
                                      text: AppLocalizations.of(context)
                                          .warning_country,
                                      smallSize: true,
                                    ),
                                    leading: Icon(
                                      Icons.notifications,
                                      color: Colors.red,
                                      size: 14.0,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
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
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        width: MediaQuery.of(context).size.width * .8,
        child: TextField(
          scrollPadding: EdgeInsets.all(25.0),
          controller: searchController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).search,
            contentPadding: EdgeInsets.all(12.0),
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
        ),
      ),
    );
  }
}
