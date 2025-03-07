import 'package:flutter/material.dart';

abstract class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Nunito';

  // Функция для расчета адаптивного размера шрифта
  static double getAdaptiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return baseSize * (screenWidth / 448); // 360 — ширина экрана дизайна
  }

  static TextStyle nunitoBold20(BuildContext context) => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: getAdaptiveFontSize(context, 20),
      );

  static TextStyle nunitoBold18(BuildContext context) => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: getAdaptiveFontSize(context, 18),
      );

  static TextStyle nunitoRegular15(BuildContext context) => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: getAdaptiveFontSize(context, 15),
      );
}
