//import 'package:contactBook/components/contactForm.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic changed;
  @override
  Widget build(BuildContext context) {
    //var deviceSize = MediaQuery.of(context).size.height / 2;
    //print(deviceSize);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text('Contact List'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Hive.openBox('testBox',
            compactionStrategy: (int total, int deleted) {
          return deleted > 20;
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final contacts = Hive.box('testBox');
              //watch box builder watches box for chnages then renders the screen
              //ones there is any changes in the box
              return WatchBoxBuilder(
                  box: contacts,
                  builder: (context, contacts) {
                    return ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts.getAt(index);
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0),
                            child: Card(
                              child: ListTile(
                                //contentPadding: EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 0),
                                onTap: () => Navigator.pushNamed(
                                    context, '/detail',
                                    arguments: {
                                      'name': contact.name,
                                      'address': contact.address,
                                      'phone': contact.phone,
                                      'index': index,
                                    }),
                                title: Text(
                                  contact.name,
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                subtitle: Text(
                                  '${contact.phone}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.supervised_user_circle,
                                  size: 33.0,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ),
                          );
                        });
                  });
            }
          } else {
            return Scaffold();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
          //this can be used if watchbuilder Isn’t in use
          /*var anyChange = await Navigator.pushNamed(context, '/add');
          setState(() {
            changed = anyChange;
          });
          */
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('testBox').compact();
    Hive.close();
    super.dispose();
  }
}
