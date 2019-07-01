import 'package:flutter/material.dart';

Future<bool> confirmDialog(BuildContext context, String title, String text) {
  ///Pop-up para confirmar exclusão de nota
  return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: new Text('$title'),
          content: Text("$text"),
          actions: <Widget>[
            new FlatButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            new FlatButton(
              child: const Text('Sim'),
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
}
