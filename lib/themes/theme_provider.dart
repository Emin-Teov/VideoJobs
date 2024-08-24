import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
        ),
      ),
      useMaterial3: true,
    );

  setLightMode() {
    currentTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
        ),
      ),
      useMaterial3: true,
    );
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white70,
        ),
      ),
      useMaterial3: true,
    );
    notifyListeners();
  }
}