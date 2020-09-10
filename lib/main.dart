import 'package:contactBook/screens/addContact.dart';
import 'package:contactBook/screens/detail.dart';
import 'package:contactBook/screens/home.dart';
import 'package:contactBook/screens/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
          primarySwatch: Colors.blue,
         primaryIconTheme: IconThemeData(
           color: Colors.purple[800],
         )
        
        ),
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/detail': (context) => Detail(),
      '/add': (context) => AddContact(),
    },
  ));
}