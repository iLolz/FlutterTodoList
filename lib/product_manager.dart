import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './confirmDialog.dart';
import './editNote.dart';
import './newNote.dart';
import 'SharedPreferences.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager({this.startingProduct});

  State<StatefulWidget> createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<String> products = List();
  String appTitle = "ToDo";

  void initList() async {
    products = await readData();
    setState(() {});
  }

  GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    initList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///PARA ANDROID
    if (Platform.isAndroid) {
      return Scaffold(
        key: _ScaffoldKey,
        appBar: AppBar(
          title: Text("$appTitle"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewNote(productList: products)),
            );
          },
          //backgroundColor: Colors.brown,
          child: Icon(Icons.add),
        ),
        body: products.length == 0
            ? Center(
          child: Text("Não há notas"),
        )
            : ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: index % 2 == 0 ? Colors.black : Colors.orange,
              indent: 20,
            ),
            padding: const EdgeInsets.all(0.0),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNote(
                        nota: index,
                        productList: products,
                      ),
                    ));
              },
              trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    confirmDialog(context, "Deseja deleter está nota",
                        products[index])
                        .then((bool) {
                      if (bool) {
                        setState(() {
                          products.removeAt(index);
                          writeData(products);
                          _ScaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Nota deletada")));
                        });
                      }
                    });
                  }),
              title: Text("${products[index]}"),
            )),
      );
    }

    /* ///PARA IOS
    if (Platform.isIOS) {}
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            automaticallyImplyLeading: true,
            automaticallyImplyTitle: true,
            largeTitle: Text("$appTitle"),
            trailing: FlatButton(
                child: Icon(
                  CupertinoIcons.add,
                  color: CupertinoColors.activeBlue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ProductControl(productList: products)),
                  );
                }),
          ),
          SliverFillRemaining(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: products
                  .map(
                    (element) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.00),
                          ),
                          //color: CupertinoColors.lightBackgroundGray,
                          margin: EdgeInsets.all(0.1),
                          //color: Colors.white70,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(element),
                                leading: IconButton(
                                  onPressed: () {
                                    ///ToDo : Confirm Dialog personalizado (Bordas arredondadas)
                                    confirmDialog(context,
                                            "Deseja apagar esta nota?", element)
                                        .then((bool) {
                                      if (bool == true)
                                        setState(() {
                                          products.remove(element);
                                        });
                                    });
                                  },
                                  icon: Icon(CupertinoIcons.delete_simple),
                                  color: CupertinoColors.inactiveGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );*/
  }
}
