import 'package:flutter/material.dart';

class Boxes {
  static Future<void> alertDialog(BuildContext context, String error) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text("An error has ocurred.")],
              ),
            ),
            actions: [
              FlatButton(
                child: Text(error),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
