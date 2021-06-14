import 'dart:io';
import 'dart:convert';
import 'planet.dart';


// class used to ingest JSON data and create strutures
// from which we can pull system names and planets lists.
// This will be used in building Planetary Systems
class Data {
  final String inputFile;
  var _planetJSON;
  var _planetData;
  var systemName;
  var planetListMap;

  Data({this.inputFile = ''}) {
    _planetJSON = File(inputFile).readAsStringSync();
    _planetData = jsonDecode(_planetJSON);
    systemName = _planetData['name'];
    planetListMap = _planetData['planets'];
  }

  String get getSystemName => systemName;
  // creates a "planet" list out of the incoming JSON
  // used by planetary_system.dart in named constructor
  List get getPlanetList {
    var planetList = <Planet>[];
    planetListMap.forEach((e) => planetList.add(Planet(
        name: e['name'].toString(), description: e['description'].toString())));
    return planetList;
  }
}
