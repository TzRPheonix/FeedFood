import 'package:flutter/material.dart';
import 'package:flutter_ydays/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences cache = await SharedPreferences.getInstance();

  runApp(App(cache: cache));
}
