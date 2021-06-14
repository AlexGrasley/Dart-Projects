import 'package:flutter/material.dart';
import 'tab_controller.dart';

class App extends StatelessWidget {
  final String title;

  const App({Key key, this.title}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainTabController(), // BusinessCard(),
    );
  }
}
