import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'business_card.dart';
import 'app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight    
  ]);
  
  runApp(App(title: "Call Me Maybe"));
}
