import 'package:flutter/material.dart';

abstract class AppThemes {
  const AppThemes._();

  static final dark = ThemeData(
    brightness: Brightness.dark,
  );

  static final light = ThemeData(
    brightness: Brightness.light,
  );
}
