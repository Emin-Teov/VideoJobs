import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_list/pages/home_list.dart';
import 'package:video_list/pages/no_internet.dart';
import 'package:video_list/pages/profile.dart';
import 'package:video_list/pages/settings.dart';
import 'package:video_list/pages/tab_list.dart';

class HomePage extends StatefulWidget {
  final String title;
  final List _pages = [const HomeList(), const Profile(), const Settings()];

  HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) => setState(() {
              _connectivityResult = result;
            }));
  }

  @override
  Widget build(BuildContext context) {
    bool get_connect_context = (_connectivityResult == ConnectivityResult.none) ? false : true;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: get_connect_context
              ? () {
                  scaffoldKey.currentState!.openDrawer();
                }
              : null,
        ),
      ),
      drawer: 
        get_connect_context ? Drawer(
          backgroundColor: Colors.blueAccent,
          child: TabList(),
        ): null,
      body: get_connect_context ? widget._pages[_select_page_index] : NoInternet(),
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
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
