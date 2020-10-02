import 'package:contactBook/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive/hive.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Map contacts;
  bool showSnacks = false;
  final snackBar = SnackBar(
    content: Text('Oops! Nothing was changed!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  void editHandler() async {
    FocusScope.of(context).unfocus(); //to dismiss keyboard
    if (_fbKey.currentState.saveAndValidate()) {
      if (contacts['name'] == _fbKey.currentState.value['name'] &&
          contacts['phone'] == int.parse(_fbKey.currentState.value['number']) &&
          contacts['address'] == _fbKey.currentState.value['address']) {
        setState(() {
          showSnacks = true;
        });
        //print('The same');
        //print(showSnacks);
      } else {
        dynamic box = Hive.box('testBox');
        Contact editedContact = Contact()
          ..name = _fbKey.currentState.value['name']
          ..phone = int.parse(_fbKey.currentState.value['number'])
          ..address = _fbKey.currentState.value['address'];

        await box.putAt(contacts['index'], editedContact);
        Navigator.pop(context, {'changed': true});
        Navigator.pop(context, {'changed': true});
        /*await Navigator.pushNamedAndRemoveUntil(
            context, '/home', (route) => false);*/
        //await Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      //print('error');
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 12.0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Text(
              contacts['name'],
              style: TextStyle(fontSize: 40.0, color: Colors.blue[700]),
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
                fontSize: 20.0,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(118.0, 0.0, 0, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      var contactBox = Hive.box('testBox');
                      contactBox..deleteAt(contacts['index']);
                      Navigator.pop(context, {'changed': true});
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.blue[600],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    color: Colors.green[700],
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          '${contacts['phone']}');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Divider(
              height: 2.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              // We will now use PageRouteBuilder
              PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, __, ___) {
                    return Scaffold(
                      backgroundColor: Colors.blue,
                      body: Container(
                          margin: EdgeInsetsDirectional.only(
                              top: 60.0, end: 13.0, bottom: 50.0, start: 13.0),
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.blue[900],
                                ),
                                onPressed: () {
                                  //exit keyboard
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                              child: FormBuilder(
                                key: _fbKey,
                                autovalidate: true,
                                child: Column(
                                  children: <Widget>[
                                    FormBuilderTextField(
                                      attribute: 'name',
                                      initialValue: contacts['name'],
                                      decoration:
                                          InputDecoration(labelText: 'Name'),
                                      keyboardType: TextInputType.name,
                                      validators: [
                                        FormBuilderValidators.required(),
                                      ],
                                    ),
                                    FormBuilderTextField(
                                      attribute: 'address',
                                      initialValue: contacts['address'],
                                      decoration:
                                          InputDecoration(labelText: 'Address'),
                                      keyboardType: TextInputType.streetAddress,
                                      validators: [
                                        FormBuilderValidators.required(),
                                      ],
                                    ),
                                    FormBuilderTextField(
                                      attribute: 'number',
                                      initialValue: '${contacts['phone']}',
                                      decoration: InputDecoration(
                                          labelText: 'Phone Number'),
                                      keyboardType: TextInputType.phone,
                                      validators: [
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.numeric(),
                                        FormBuilderValidators.minLength(11),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () => {editHandler()},
                                      icon: Icon(Icons.save,
                                          size: 34.0, color: Colors.blue[900]),
                                    ),
                                    showSnacks
                                        ? Scaffold.of(context)
                                            .showSnackBar(snackBar)
                                        : Text(''),
                                  ],
                                ),
                              ),
                            ),
                          ])),
                    );
                  }));
        },
        child: Icon(
          Icons.mode_edit,
        ),
        backgroundColor: Colors.blue[800],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
