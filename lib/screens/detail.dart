import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
              context: context, 
              backgroundColor: Colors.transparent,
              builder: (context) => Scaffold(
              
              )
              ),
        child: Icon(
          Icons.mode_edit
        ),
        backgroundColor: Colors.purple[800],
        ),
    );
  }
}