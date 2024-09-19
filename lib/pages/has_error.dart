import 'package:flutter/material.dart';
import '/pages/get_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HasError extends StatelessWidget {
  final bool no_internet;

  const HasError({
    super.key,
    this.no_internet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: GetTextField(text: 'JobTube', light: true),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(no_internet ? Icons.signal_wifi_off_outlined : Icons.error),
            GetTextField(
                text: no_internet ? AppLocalizations.of(context).no_internet : AppLocalizations.of(context).error),
          ],
        ),
      ),
    );
  }
}
