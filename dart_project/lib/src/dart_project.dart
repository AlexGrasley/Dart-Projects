import 'dart:io';
import 'package:dart_project/dart_project.dart';
import 'planetary_system.dart';
import 'planet.dart';

class SpaceAdventure {
  final PlanetarySystem planetarySystem;

  SpaceAdventure({this.planetarySystem});

  void start() {
    printGreeting();
    printIntroduction(getName());
    print('Let\'s go on an adventure!');
    if (planetarySystem.hasPlanets) {
      travel(promptForRandomOrSpecificDest(
          'Shall I rondomly choose a planet for you to visit? (Y or N)'));
    } else {
      print(
          'It appears something went wrong....There are no planets to explore.');
    }
  }

  void printGreeting() {
    print('welcome to the ${planetarySystem.name}!');
    print('There are ${planetarySystem.numberOfPlanets} planets to explore');
  }

  String getName() {
    print('What is your name?');
    return stdin.readLineSync();
  }

  void printIntroduction(String name) {
    print(
        'Nice to meet you, $name. My name is Eliza, I\'m an old friend of Alexa.');
  }

  String responseToPrompt(String prompt) {
    print(prompt);
    return stdin.readLineSync();
  }

  void travelTo(Planet planet) {
    print('Traveling to the ${planet.name}.\n');
    print('Arrived at ${planet.name}. ${planet.description}\n');
  }

  void travel(bool randomDest) {
    Planet planet;
    if (randomDest) {
      planet = planetarySystem.randomPlanet();
    } else {
      planet = planetarySystem.planetWithName(
          responseToPrompt('Name the planet you would like to visit.'));
    }
    travelTo(planet);
  }

  bool promptForRandomOrSpecificDest(String prompt) {
    String answer;
    while (answer != 'Y' && answer != 'N') {
      answer = responseToPrompt(prompt);
      if (answer == 'Y') {
        return true;
      } else if (answer == 'N') {
        return false;
      } else {
        print('Sorry, I didn\'t get that');
      }
    }

    return false;
  }
}
