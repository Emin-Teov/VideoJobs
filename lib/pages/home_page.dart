import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:public_ip_address/public_ip_address.dart';

import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/home_list.dart';
import 'package:video_list/pages/has_error.dart';
import 'package:video_list/pages/profile.dart';
import 'package:video_list/pages/profile_tab.dart';
import 'package:video_list/pages/setting_tab.dart';
import 'package:video_list/pages/settings.dart';
import 'package:video_list/pages/type_tab.dart';
import 'package:video_list/models/data_model.dart';
import 'package:video_list/models/category_model.dart';

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
    for (var category_data in data.categories) {
      CategoryModel category = CategoryModel.fromJson(category_data);
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
    _category_count = _category_query.length;
    return data;
  }

  Future<String> getCountryIp() async {
    String code = await IpAddress().getCountryCode();
    _country_query = {code};
    return code;
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  Set<String> _country_query = {};
  Set<double> _category_query = {};
  late int _category_count;
  int _select_page_index = 0;

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
      body: FutureBuilder<List>(
        future: Future.wait([
          getCountryIp(),
          fetchData(http.Client()),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return HasError(
              title: 'JobTube',
              no_internet: _connectivityResult == ConnectivityResult.none,
            );
          } else if (snapshot.hasData) {
            List _pages = [
              HomeList(
                job_seekers: snapshot.data![1].job_seekers,
                offers: snapshot.data![1].offers,
                freelancers: snapshot.data![1].freelancers,
                talents: snapshot.data![1].talents,
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
                        categories: snapshot.data![1].categories,
                        countries: snapshot.data![1].countries,
                        country_codes: _country_query,
                        category_codes: _category_query,
                        category_count: _category_count,
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
