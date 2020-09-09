import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Text('Contact List'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, '/detail'),
              title: Text('Contacts'),
              leading: Icon(Icons.supervised_user_circle),
            ),
          );
        }
        ),
        floatingActionButton: FloatingActionButton(onPressed: null),
        
        );
  }
}
