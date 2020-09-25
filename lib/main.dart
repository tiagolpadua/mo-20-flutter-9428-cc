import 'package:bytebank/screens/dashboart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppConfig(),
      child: BytebankApp(),
    ),
  );
}

class AppConfig extends ChangeNotifier {
  bool _darkMode = true;

  bool get darkMode {
    return _darkMode;
  }

  void toggleDarkMode() {
    this._darkMode = !this._darkMode;
    print('Dark mode now is $_darkMode');
    notifyListeners();
  }
}


class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig();
    return MaterialApp(
      theme: appConfig.darkMode
          ? ThemeData.dark()
          : ThemeData(
              primaryColor: Colors.green[900],
              accentColor: Colors.blueAccent[700],
              buttonTheme: ButtonThemeData(
                  buttonColor: Colors.blueAccent[700],
                  textTheme: ButtonTextTheme.primary),
            ),
      home: SafeArea(child: Dashboard()),
    );
  }
}

