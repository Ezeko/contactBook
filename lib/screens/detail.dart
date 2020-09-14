import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Map contacts;
  @override
  Widget build(BuildContext context) {
    contacts = ModalRoute.of(context).settings.arguments;
    if (contacts == null) {
      contacts = ModalRoute.of(context).settings.arguments;
    }
    print(contacts);
    //contacts = contacts.isNotEmpty ? contacts : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Scaffold(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Scaffold()),
        child: Icon(Icons.mode_edit),
        backgroundColor: Colors.purple[800],
      ),
    );
  }
}
