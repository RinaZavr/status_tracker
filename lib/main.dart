import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:status_tracker/scr/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Инициализация Flutter
  // await initializeDateFormatting('ru', null); // Инициализация русской локализации
  runApp(const App());
}
