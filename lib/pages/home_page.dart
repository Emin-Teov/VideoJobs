import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:public_ip_address/public_ip_address.dart';
import 'package:video_list/models/country_model.dart';

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
    _categories = [];
    for (var category_data in data.categories) {
      CategoryModel category = CategoryModel.fromJson(category_data);
      _categories.add(category);
      if (category.children.isEmpty) {
        _category_query.add(category.number);
      } else {
        for (var category_sub_data in category.children) {
          CategoryModel sub_category =
              CategoryModel.fromJson(category_sub_data);
          _category_query.add(sub_category.number);
        }
      }
    }
    String code = await IpAddress().getCountryCode();
    _countries = [];
    data.countries.forEach((e) {
      CountryModel country = CountryModel.fromJson(e);
      _countries.add(country);
      if (country.code == code)
        _country_query = {country.code};
    });
    return data;
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  int _select_page_index = 0;
  Set<double> _category_query = {};
  Set<String> _country_query = {};
  late List<CategoryModel> _categories;
  late List<CountryModel> _countries;

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
                country_query: _country_query,
                category_query: _category_query,
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
                        categories: _categories,
                        countries: _countries,
                        country_codes: _country_query,
                        category_codes: _category_query,
                      )
                    : _select_page_index == 1
                        ? ProfileTab()
                        : SettingTab(),
              ),
              body: _pages[_select_page_index],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _select_page_index,
                onTap: _select_page,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
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
