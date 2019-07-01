import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'confirmDialog.dart';
import 'dart:io' show Platform;

class NewNote extends StatefulWidget {
  NewNote({this.productList});
  final List<String> productList;

  @override
  _NewNoteState createState() => _NewNoteState(productList: productList);
}

class _NewNoteState extends State<NewNote> {
  final List<String> productList;
  final GlobalKey<ScaffoldState> _ScaffoldKey = new GlobalKey<ScaffoldState>();
  _NewNoteState({this.productList});

  final _textControl = TextEditingController();

  String appName = "ToDo";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return Scaffold(
        key: _ScaffoldKey,
        appBar: AppBar(
          title: Text("$appName"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: const Alignment(1.0, 0.0),
            children: <Widget>[
              TextField(
                autofocus: true,
                autocorrect: true,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: ('Insira o lembrete!'),
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.00),
                    ),
                  ),
                ),
                controller: _textControl,
                cursorColor: Colors.orange,
                cursorRadius: Radius.circular(16.0),
                cursorWidth: 16.0,
              ),
              IconButton(
                onPressed: () {
                  _textControl.clear();
                },
                icon: Icon(Icons.clear),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_textControl.text.isNotEmpty) {
              productList.add(_textControl.text);
              Navigator.pop(context);
            } else {
              _ScaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Campo vazio, digite algo para salvar!"),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: Icon(Icons.save),
        ),
      );

    if (Platform.isIOS)
      return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("$appName"),
          trailing: FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancelar",
                style: TextStyle(color: CupertinoColors.activeBlue),
              )),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                autofocus: true,
                placeholder: "Insira o lembrete",
                autocorrect: true,
                controller: _textControl,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.0,
                    color: CupertinoColors.activeBlue,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: CupertinoButton(
                    child: Text("Adicionar"),
                    color: CupertinoColors.activeBlue,
                    borderRadius: BorderRadius.circular(35.00),
                    onPressed: () {
                      if (_textControl.text.isNotEmpty) {
                        productList.add(_textControl.text);
                      }
                      Navigator.pop(context);
                    }),
              ),
            ),
          ],
        ),
      );
    _textControl.dispose();
  }
}
