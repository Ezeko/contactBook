import 'package:contactBook/screens/home.dart';
import 'package:contactBook/screens/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
    },
  ));
}