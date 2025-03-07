import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:status_tracker/scr/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Инициализация Flutter
  // debugPaintSizeEnabled = true;
  runApp(const App());
}
