import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/profile.dart';
import 'package:video_list/pages/settings.dart';
import 'package:video_list/pages/video_items.dart';

class HomePage extends StatefulWidget {
  final String title;
  final List _pages = [const VideoItems(), const Profile(), const Settings()];

  HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _select_page_index = 0;

  void selectPage(int index) {
    setState(() {
      _select_page_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.blueAccent,
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.only(top: 85.0),
              child: GetTextField(text: "Job types"),
            ),
          ],
        ),
      ),
      body: widget._pages[_select_page_index],
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
