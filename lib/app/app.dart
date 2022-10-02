import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../feature/home/screens/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate
        // ],
        // supportedLocales: [
        //   const Locale('ru'),
        // ],
      home: HomePage(),
    );
  }
}
