import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../models/contact.dart';
import 'package:hive/hive.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  var loader;
  bool loading;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  void submissionHandler() async {
    if (_fbKey.currentState.saveAndValidate()) {
      Map formValue = _fbKey.currentState.value;

      dynamic box = await Hive.openBox('testBox');

      Contact contact = Contact()
        ..name = formValue['name']
        ..phone = int.parse(formValue['number'])
        ..address = formValue['address'];

      await box.add(contact);
      Navigator.pop(context, {'changed': true});

      //print((_fbKey.currentState.value).runtimeType);
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FormBuilder(
        key: _fbKey,
        autovalidate: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                autofocus: true,
                autovalidate: true,
                attribute: "name",
                decoration: InputDecoration(labelText: "Name"),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                validators: [
                  FormBuilderValidators.required(),
                ],
                autofillHints: null,
              ),
              FormBuilderTextField(
                attribute: "address",
                decoration: InputDecoration(labelText: "Address"),
                keyboardType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.words,
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderTextField(
                attribute: "number",
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: '2348012345678'
                ),
                keyboardType: TextInputType.phone,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.minLength(13),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton.icon(
                color: Colors.purple[500],
                onPressed: ()  {
                  submissionHandler();
                },
                icon: Icon(
                  Icons.system_update_alt,
                  color: Colors.white,
                ),
                label: Text(
                  'Create Contact',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
