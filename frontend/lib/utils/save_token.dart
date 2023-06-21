import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';

void saveTokenToCache(BuildContext context, String token) async {
  final SharedPreferences cache = await SharedPreferences.getInstance();

  cache.setString('token', token);
  // ignore: use_build_context_synchronously
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => App(
        cache: cache,
      ),
    ),
  );
}
