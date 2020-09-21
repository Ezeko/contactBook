import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilder(
        key: _fbKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                autofocus: true,
                autovalidate: true,
                attribute: 'name',
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),

              FormBuilderTextField(
                attribute: 'address',
                decoration: InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.streetAddress,
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),

              FormBuilderTextField(
                attribute: 'number',
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.minLength(11),
                ],
              ),

            ],
          ),
        ),
    );
  }
}