import 'package:flutter/material.dart';

class DialogAddStock extends StatefulWidget {
  @override
  _DialogAddStockState createState() => _DialogAddStockState();
}

class _DialogAddStockState extends State<DialogAddStock> {
  bool cansave = false;
  String stock;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Add New Stock"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("ADD"),
            onPressed: () {Navigator.of(context).pop(stock);},
          )
        ],
      ),
      body: new Form(
        child: new TextField(
          onChanged: (String value){
            stock = value;
            cansave = value.isNotEmpty;
          },
        ),
      ),
    );
  }
}