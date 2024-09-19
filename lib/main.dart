import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';
import '/services/database_service.dart';
import '/themes/theme_provider.dart';
import '/pages/home_page.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    _databaseService.deleteDatabase();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobTube',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale('en'),
      home: HomePage(),
    );
  }
}
