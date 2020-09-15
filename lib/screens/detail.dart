import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    //print(contacts);
    //contacts = contacts.isNotEmpty ? contacts : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Text(
            contacts['name'],
            style: TextStyle(fontSize: 40.0, color: Colors.purple[700]),
          ),
          Divider(),
          SizedBox(
            height: 12.0,
          ),
          Text(
            contacts['address'],
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            '${contacts['phone']}',
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          RaisedButton.icon(
            onPressed: () async {
              var contactBox = Hive.box('testBox');
               contactBox
                ..deleteAt(contacts['index']);
              Navigator.pop(context, {
                'changed': true
              });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.purple[300],
            ),
            label: Text(''),
            color: Colors.white,
          ),
          SizedBox(
            height: 12.0,
          ),
          Divider(
            height: 2.0,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Scaffold()),
        child: Icon(
          Icons.mode_edit,
        ),
        backgroundColor: Colors.purple[800],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
