import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size.height / 2;
    print(deviceSize);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text('Contact List'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 0),
              child: Card(
                child: ListTile(
                  //contentPadding: EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 0),
                  onTap: () => Navigator.pushNamed(context, '/detail'),
                  title: Text('Contacts'),
                  leading: Icon(Icons.supervised_user_circle),
                ),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => Card(
                    child: Center(
                      child: Scaffold(
                          body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Add Contact Here',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              textAlignVertical: TextAlignVertical.top,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',

                              ),
                            )
                          ],
                        ),

                      ),

                      ),
                    ),
                  ),

                  );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
