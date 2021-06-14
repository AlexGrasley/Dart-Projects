import 'dart:math';
import 'ingest.dart';
import 'planet.dart';

class PlanetarySystem {
  String name;
  List<Planet> planets;
  final Random _random = Random();

  PlanetarySystem({this.name = 'Unnamed System', this.planets = const []});

  PlanetarySystem.systemFromFile(String fileName) {
    var incomingData = Data(inputFile: fileName);
    name = incomingData.getSystemName;
    planets = incomingData.getPlanetList;
  }

  int get numberOfPlanets => planets.length;
  bool get hasPlanets => planets.isNotEmpty;

  Planet randomPlanet() {
    if (!hasPlanets) return Planet.nullPlanet();
    return planets[_random.nextInt(planets.length)];
  }

  Planet planetWithName(String name) {
    return planets.firstWhere((planet) => planet.name == name,
        orElse: () => Planet.nullPlanet());
  }
} // Planetary System
