import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> readData() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final myStringList = await sharedPrefs.getStringList('noteList') ?? [];
  return myStringList;
}

Future<bool> writeData(List<String> nota) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sharedPrefs.setStringList('noteList', nota);
}

