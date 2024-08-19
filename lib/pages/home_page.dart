import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/home_list.dart';
import 'package:video_list/pages/no_internet.dart';
import 'package:video_list/pages/profile.dart';
import 'package:video_list/pages/settings.dart';
import 'package:video_list/pages/tab_list.dart';
import 'package:video_list/models/data_model.dart';

Future<DataModel> fetchData(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://emin-teov.github.io/api/json/data.json'));
  final json = jsonDecode(response.body) as Map<String, dynamic>;

  return DataModel.fromJson(json);
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<DataModel> futureData;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  int _select_page_index = 0;

  void selectPage(int index) {
    setState(() {
      _select_page_index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData(http.Client());

    Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) => setState(() {
        _connectivityResult = result;
      }));
  }

  @override
  Widget build(BuildContext context) {
    bool get_connect_context =
        (_connectivityResult == ConnectivityResult.none) ? false : true;
    return Scaffold(
      body: FutureBuilder<DataModel>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error),
                  GetTextField(
                    text: "An error has occurred!",
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            List _pages = [HomeList(job_seekers: snapshot.data!.job_seekers, offers: snapshot.data!.offers,), Profile(), Settings()];
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: GetTextField(text: widget.title, light: true),
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: get_connect_context
                      ? () {
                          scaffoldKey.currentState!.openDrawer();
                        }
                      : null,
                ),
              ),
              drawer: get_connect_context
                  ? Drawer(
                      backgroundColor: Colors.blueAccent,
                      child: TabList(
                        categories: snapshot.data!.categories,
                        countries: snapshot.data!.countries,
                      ),
                    )
                  : null,
              body: get_connect_context
                  ? _pages[_select_page_index]
                  : NoInternet(),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _select_page_index,
                onTap: selectPage,
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
  // }
}
