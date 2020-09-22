import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/dashboart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());

//  save(Contact(1, "tiago", 123456)).then(
//    (value) => findAll().then(
//      (contacts) => print('${contacts}'),
//    ),
//  );
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary)),
      home: SafeArea(child: Dashboard()),
    );
  }
}
