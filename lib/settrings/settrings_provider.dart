import 'package:flutter/material.dart';

class SettringsProvider extends ChangeNotifier {
  final List<String> languages = ['EN', 'AZ'];
  String language = 'EN';
  ThemeData? currentTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.black87,
      ),
    ),
    useMaterial3: true,
  );

  setLang(int index) {
    language = languages[index];
    notifyListeners();
  }

  setStyle(bool light) {
    currentTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: light ? Brightness.light : Brightness.dark,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: light ? Colors.black87 : Colors.white70,
        ),
      ),
      useMaterial3: true,
    );
    notifyListeners();
  }
}
