import 'package:flutter/material.dart';
import 'package:flutter_ydays/config/routes.dart';
import 'package:flutter_ydays/pages/home.dart';

class App extends StatefulWidget {
  const App({required this.cache, super.key});
  // ignore: prefer_typing_uninitialized_variables
  final cache;

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primaryColor: const Color(0xFFA16F68),
        hintColor: const Color(0xFFDAC7C4),
      ),
      routes: routes(context, widget.cache),
      initialRoute: Home.routeName,
    );
  }
}
