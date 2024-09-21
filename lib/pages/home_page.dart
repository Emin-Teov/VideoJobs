import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:public_ip_address/public_ip_address.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/pages/get_text_field.dart';
import '/pages/home_list.dart';
import '/pages/has_error.dart';
import '/pages/profile.dart';
import '/pages/profile_tab.dart';
import '/pages/setting_tab.dart';
import '/pages/settings.dart';
import '/pages/type_tab.dart';
import '/models/data_model.dart';
import '/models/category_model.dart';
import '/models/country_model.dart';

class HomePage extends StatefulWidget {
  final String query;

  HomePage({
    super.key,
    this.query = '',
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<DataModel> fetchData(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://emin-teov.github.io/api/json/data.json'));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    DataModel data = DataModel.fromJson(json);
    categories = [];
    for (var category_data in data.categories) {
      CategoryModel category = CategoryModel.fromJson(category_data);
      categories.add(category);
      if (category.children.isEmpty) {
        categoryQuery.add(category.number);
      } else {
        for (var category_sub_data in category.children) {
          CategoryModel sub_category =
              CategoryModel.fromJson(category_sub_data);
          categoryQuery.add(sub_category.number);
        }
      }
    }
    String code = await IpAddress().getCountryCode();
    countries = [];
    data.countries.forEach((e) {
      CountryModel country = CountryModel.fromJson(e);
      countries.add(country);
      if (country.code == code)
        countryQuery = {country.code};
    });
    return data;
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  int _select_page_index = 0;
  Set<double> categoryQuery = {};
  Set<String> countryQuery = {};
  late List<CategoryModel> categories;
  late List<CountryModel> countries;

  void _select_page(int index) {
    setState(() {
      _select_page_index = index;
    });
  }

  @override
  void initState() {
    super.initState();

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) => setState(() {
              _connectivityResult = result;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return HasError(
              no_internet: _connectivityResult == ConnectivityResult.none,
            );
          } else if (snapshot.hasData) {
            List _pages = [
              HomeList(
                job_seekers: snapshot.data!.job_seekers,
                offers: snapshot.data!.offers,
                freelancers: snapshot.data!.freelancers,
                talents: snapshot.data!.talents,
                country_query: countryQuery,
                category_query: categoryQuery,
              ),
              Profile(),
              Settings()
            ];
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: GetTextField(text: 'JobTube', light: true),
              ),
              drawer: Drawer(
                backgroundColor: Colors.blueAccent,
                child: _select_page_index == 0
                    ? TypeTab(
                        categories: categories,
                        countries: countries,
                        country_codes: countryQuery,
                        category_codes: categoryQuery,
                      )
                    : _select_page_index == 1
                        ? ProfileTab()
                        : SettingTab(),
              ),
              body: _pages[_select_page_index],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _select_page_index,
                onTap: _select_page,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: AppLocalizations.of(context).home,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: AppLocalizations.of(context).profile,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: AppLocalizations.of(context).settings,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
