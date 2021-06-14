import 'dart:math';

class Answers {
  final Random rand = Random();
  int _currentValue = 0;

  Answers();

  String get currentValue => answers[_currentValue];

  List<String> answers = [
    "How did your brain even learn human speech?",
    "I've been under fire before. Well ... I've been in a fire. Actually, I was fired. I can handle myself.",
    "I cannot abide useless people.",
    "Well, maybe I'm not a fancy gentleman like you, with your ... very fine hat. But I do business. We're here for business.",
    "Terse? I can be terse. Once, in flight school, I was laconic.",
    "Also? I can kill you with my brain.",
    "I swear by my pretty floral bonnet, I will end you.",
    "Let's go be bad guys!",
  ];

  void roll() => _currentValue = rand.nextInt(8);
}
