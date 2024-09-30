import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';
import 'settrings/settrings_provider.dart';
import '/pages/home_page.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettringsProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<SettringsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobTube',
      theme: _provider.currentTheme,
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale(_provider.language.toLowerCase()),
      home: HomePage(),
    );
  }
}