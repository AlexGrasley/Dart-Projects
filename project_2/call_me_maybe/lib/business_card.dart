import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCard extends StatelessWidget {
  BusinessCard({Key key}) : super(key: key);

  final String title = "Business Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: adaptLayout(context));
  }
}

Widget adaptLayout(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return landscapeLayout(context);
  } else {
    return portraitLayout(context);
  }
}

void launchSMS(BuildContext context) async {
  if (await canLaunch('sms:9995550123')) {
    launch('sms:9995550123');
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Unable to load SMS!"),
    ));
  }
}

void launchMail(BuildContext context) async {
  if (await canLaunch("mailTo: <CptReynolds@serenity.space>")) {
    launch("mailTo: <CptReynolds@serenity.space>");
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Unable to load Email!"),
    ));
  }
}

void launchURL(BuildContext context) async{
  
  if (await canLaunch("https://BewareTheReavers.co.sm")) {
    launch("https://BewareTheReavers.co.sm");
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Unable to load Web Browser!"),
    ));
  }
}

Widget landscapeLayout(BuildContext context) {
  return Container(
      padding: EdgeInsets.all(30),
      color: Colors.black,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(1),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset('assets/mal.jpg')))),
          ),
          Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Expanded(child: textItem("Malcom Reynolds")),
                Expanded(child: textItem("Captain")),
                GestureDetector(
                    onTap: () => launchSMS(context),
                    child: Expanded(child: textItem("999-555-0123"))),
                GestureDetector(
                    onTap: () => launchMail(context),
                    child: Expanded(
                        child: textItem("CptReynolds@serenity.space"))),
                GestureDetector(
                    onTap: () => launchURL(context),
                    child: Expanded(
                        child: textItem("https://BewareTheReavers.co.sm")))
              ]))
        ],
      ));
}

Widget portraitLayout(BuildContext context) {
  return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset('assets/mal.jpg'))),
          ),
          textItem("Malcom Reynolds"),
          textItem("Captain"),
          GestureDetector(
              onTap: () => launchSMS(context),
              child: Expanded(child: textItem("999-555-0123"))),
          Container(
            padding: EdgeInsets.all(0),
            child: Row(
            children: [
              GestureDetector(
                  onTap: () => launchMail(context),
                  child:
                      Expanded(child: textItem("CptReynolds@serenity.space"))),
              GestureDetector(
                  onTap: () => launchURL(context),
                  child: Expanded(
                      child: textItem("https://MyShipSeren.co")))
            ],
          ))
        ],
      )));
}

Widget textItem(String text) {
  return Padding(
      padding: EdgeInsets.all(5),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            child: Text(text),
            padding: EdgeInsets.all(5),
            color: Colors.deepOrange,
            alignment: Alignment.center,
          )));
}
