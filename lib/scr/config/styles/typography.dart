import 'package:flutter/material.dart';

abstract class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Nunito';

  static const nunitoBold24 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static const nunitoBold15 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );

  static const nunitoRegular13 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );
}
