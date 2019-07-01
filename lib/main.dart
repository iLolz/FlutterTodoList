import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './product_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.orange,
            accentColor: Colors.orange,
            secondaryHeaderColor: Colors.brown.shade100),
        home: ProductManager());
  }
}
