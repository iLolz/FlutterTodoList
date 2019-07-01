import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class EditNote extends StatefulWidget {
  EditNote({this.productList, this.nota});
  final List<String> productList;
  final int nota;

  @override
  _EditNoteState createState() =>
      _EditNoteState(productList: productList, notaIndex: nota);
}

class _EditNoteState extends State<EditNote> {
  final List<String> productList;
  final notaIndex;
  _EditNoteState({this.productList, this.notaIndex});

  final _textControl = TextEditingController();

  String appName = "ToDo";

  void _initTextField() async {
    if (notaIndex != null) {
      _textControl.value = TextEditingController.fromValue(
              new TextEditingValue(text: productList[notaIndex].toString()))
          .value;
    }
  }

  @override
  void initState() {
    _initTextField();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return Scaffold(
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
            if (notaIndex == null) {
              if (_textControl.text.isNotEmpty) {
                productList.add(_textControl.text);
              }
            } else {
              productList[notaIndex] = _textControl.value.text;
            }
            Navigator.pop(context);
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
                // maxLength: 30,
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
