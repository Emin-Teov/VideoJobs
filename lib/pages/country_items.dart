import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:public_ip_address/public_ip_address.dart';

import '/models/country_model.dart';
import '/pages/country_item.dart';
import '/pages/get_text_field.dart';

class CountryItems extends StatefulWidget {
  final Set<String> codes;
  final List<CountryModel> items;

  const CountryItems({
    super.key,
    required this.codes,
    required this.items,
  });

  @override
  State<CountryItems> createState() => _CountryItemsState();
}

class _CountryItemsState extends State<CountryItems> {
  late Future<List<CountryModel>> futureCountries;

  void _set_countries(String code) {
    setState(() {
      widget.codes.contains(code)
          ? widget.codes.remove(code)
          : widget.codes.add(code);
    });
  }

  Future<String> getCountryIp() async {
    String code = await IpAddress().getCountry();
    return code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Checkbox(
                      value: widget.codes.length == widget.items.length,
                      onChanged: (value) => {
                            setState(() {
                              if (widget.codes.length == widget.items.length) {
                                widget.codes.clear();
                              } else {
                                for (CountryModel item in widget.items) {
                                  !widget.codes.contains(item.code)
                                      ? widget.codes.add(item.code)
                                      : null;
                                }
                              }
                            }),
                          }),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: GetTextField(text: AppLocalizations.of(context).all),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {

                  return Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: CountryItem(
                      id: widget.items[index].id,
                      title: AppLocalizations.of(context)
                          .countries(widget.items[index].code),
                      value: widget.codes.contains(widget.items[index].code),
                      onBoxChanged: () =>
                          _set_countries(widget.items[index].code),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
