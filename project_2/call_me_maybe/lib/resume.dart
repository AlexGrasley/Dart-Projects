import 'package:flutter/material.dart';

class Resume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    // A fixed-height child.
                    color: Colors.black, // Yellow
                    height: 125.0,
                    alignment: Alignment.centerLeft,
                    child: contactInfo(context),
                  ),
                  resumeItem("Captain", "self-employed", "2547", "Serenity",
                      "I have maintained captancy over an unruly but loyal crew for a number of years."),
                  resumeItem("Ranch Hand", "Seven Pines Pass Ranch", "2470-2490", "Seven Pines Pass",
                      "I worked every possible job a ranch could have, when a job needed done, I did it."),
                  resumeItem("Partial Translator", "Shen-Yu Translation Services", "2490-2491", "various",
                      "I translated enlish sayings into Chinese sayings."),
                  resumeItem("Private", "Independents Army", "2500", "Union of Allied Planets",
                      "I started as a grunt in the Unification War, trying to attain peace for our alliance"),
                  resumeItem("Sergent", "Independents Army", "2510", "New Kasmir",
                      "As Sergent I lead a small team of soldiers in many conflicts including the Battle of Du-Khang"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget resumeItem(String jobTitle, String company, String date,
      String location, String descript) {
    return Container(
        decoration: BoxDecoration(border: Border.all(), color: Colors.deepOrange,),
        alignment: Alignment.center,
        height: 150.00,
        child: Column(
          children: [
            resumeItemPreamble(jobTitle, company, date, location),
            resumeItemDescript(descript)
          ],
        ));
  }

  Widget resumeItemPreamble(
      String jobTitle, String company, String date, String location) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(alignment: Alignment.centerLeft, child: resumeTextItem(jobTitle)),
          Container(alignment: Alignment.centerLeft, child: resumeTextItem(company)),
          Container(alignment: Alignment.centerLeft, child: resumeTextItem(date)),
          Container(alignment: Alignment.centerLeft, child: resumeTextItem(location)),
        ],
      ),
    );
  }

  Widget resumeItemDescript(String descript) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(15),
      child: resumeTextItem(descript),
    );
  }

  Widget resumeTextItem(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "consolas",
        fontSize: 15,
      ),
    );
  }

  Widget contactInfo(BuildContext context) {
    return Expanded(
        child: Container(
            color: Colors.black,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            //height: 150,
            child: Column(
              children: [
                Text(
                  "Malcom Reynolds",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: "Times New Roman"),
                ),
                Text("Ph: 999-555-0123",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Times New Roman")),
                Text("Email: CptReynolds@serenity.space",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Times New Roman")),
              ],
            )));
  }
}
