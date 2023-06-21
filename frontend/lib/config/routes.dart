import 'package:flutter/material.dart';
import 'package:flutter_ydays/pages/home.dart';
import 'package:flutter_ydays/pages/login.dart';
import 'package:flutter_ydays/pages/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, WidgetBuilder> routes(
  BuildContext context,
  SharedPreferences cache,
) {
  bool isLogged = cache.containsKey('token');
  try {
    // JWT.verify(cache.getString('token')!, SecretKey(TOKEN_SECRET));
  } catch (e) {
    isLogged = false;
  }
  Map<String, WidgetBuilder> routes = {
    Home.routeName: (context) => isLogged ? const Home() : const LoginPage(),
    LoginPage.routeName: (context) =>
        isLogged ? const Home() : const LoginPage(),
    SubscribePage.routeName: (context) =>
        isLogged ? const Home() : const SubscribePage(),
  };
  return routes;
}
