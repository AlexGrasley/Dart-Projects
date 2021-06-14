import 'package:call_me_maybe/oracle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'business_card.dart';
import 'resume.dart';
import 'oracle.dart';

class MainTabController extends StatelessWidget {
  static const tabs = [
    Tab(text: "Business Card"),
    Tab( text: "Resume"),
    Tab(text: "Oracle"),
  ];

  final screens = [BusinessCard(), Resume(), Oracle()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            title: Text('Call Me Maybe'),
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: screens,
          ),
        ));
  }
}
