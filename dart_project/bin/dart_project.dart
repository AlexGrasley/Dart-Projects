import 'package:dart_project/dart_project.dart';


void main(List<String> arguments) {
  // check for supplied JSON file in program input
  // print error if file no supplied
  if (arguments.isEmpty) {
    print('please specify the JSON file to load.');
    return; // exit program
  }

  SpaceAdventure(
          planetarySystem:
              PlanetarySystem.systemFromFile(arguments[0]))
      .start();
}
