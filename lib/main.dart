import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_list/pages/home_page.dart';
import 'package:video_list/themes/theme_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobTube',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: HomePage(),
    );
  }
}