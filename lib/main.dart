import 'package:contactBook/screens/detail.dart';
import 'package:contactBook/screens/home.dart';
import 'package:contactBook/screens/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
            )
          )
        ),
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/detail': (context) => Detail()
    },
  ));
}