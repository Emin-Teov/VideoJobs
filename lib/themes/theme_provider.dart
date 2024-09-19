import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

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

  setStyle(bool light) {
    currentTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: light ? Brightness.light : Brightness.dark,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: light
            ? Colors.black87
            : Colors.white70,
        ),
      ),
      useMaterial3: true,
    );
    notifyListeners();
  }
}
