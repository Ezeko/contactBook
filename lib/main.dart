import 'package:contactBook/models/contact.dart';
import 'package:contactBook/screens/addContact.dart';
import 'package:contactBook/screens/detail.dart';
import 'package:contactBook/screens/home.dart';
import 'package:contactBook/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive
  ..init(appDir.path)
  ..registerAdapter(ContactAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryIconTheme: IconThemeData(
          color: Colors.purple[800],
        )),
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/detail': (context) => Detail(),
      '/add': (context) => AddContact(),
    },
  );
  }
}