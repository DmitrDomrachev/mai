import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../assets/assets.dart';
import '../feature/home/screens/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('ru'),
        ],
      // theme: dayTheme,
      // darkTheme: nightTheme,
      home: const HomePage(),
    );
  }
}
