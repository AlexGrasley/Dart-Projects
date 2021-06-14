import 'package:flutter/material.dart';
import 'oracle_answer_model.dart';

class Oracle extends StatefulWidget {
  @override
  _OracleState createState() => _OracleState();
}

class _OracleState extends State<Oracle> {
  
  final answer = Answers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.black,
        child: Column(
          children: [
            GestureDetector(
                onTap: () => setState(() {
                      answer.roll();
                    }),
                child: oracleButton()),
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Center(
                    child: Text(
                  "${answer.currentValue}",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )))
          ],
        ),
      ),
    );
  }
}

Widget oracleButton() {
  return Flexible(
      child: Container(
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      shape: BoxShape.rectangle,
      color: Colors.deepOrange,
    ),
    child: Center(child: Text("Hear the Oracle")),
  ));
}
