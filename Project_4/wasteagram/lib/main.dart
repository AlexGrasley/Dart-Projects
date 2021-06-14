import 'package:flutter/material.dart';
import 'package:wasteagram/wasteagramapp.dart';
import 'package:wasteagram/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WasteagramApp());
}
