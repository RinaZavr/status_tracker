import 'package:flutter/material.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';

@immutable
class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors._({
    required this.textColor,
    required this.secondaryTextColor,
    required this.backgroundColor,
    required this.buttonColor,
    required this.backgroungIconColor,
    required this.lightBorderColor,
    required this.darkBorderColor,
    required this.remoteColor,
    required this.diseaseColor,
    required this.vacationColor,
    required this.studyColor,
    required this.otherColor,
  });

  const ThemeColors.light()
      : textColor = AppColors.gainsboro,
        secondaryTextColor = AppColors.dimgray,
        backgroundColor = AppColors.raisinblack,
        buttonColor = AppColors.rajah,
        backgroungIconColor = AppColors.onyx,
        lightBorderColor = AppColors.arsenic,
        darkBorderColor = AppColors.bleudefrance,
        remoteColor = AppColors.celestialblue,
        diseaseColor = AppColors.popstar,
        vacationColor = AppColors.ruddybrown,
        studyColor = AppColors.royalpurple,
        otherColor = AppColors.polishedpine;

  const ThemeColors.dark()
      : textColor = AppColors.raisinblacksecond,
        secondaryTextColor = AppColors.gray,
        backgroundColor = AppColors.white,
        buttonColor = AppColors.rajah,
        backgroungIconColor = AppColors.white,
        lightBorderColor = AppColors.platinum,
        darkBorderColor = AppColors.pictonblue,
        remoteColor = AppColors.celestialblue,
        diseaseColor = AppColors.popstar,
        vacationColor = AppColors.ruddybrown,
        studyColor = AppColors.royalpurple,
        otherColor = AppColors.polishedpine;

  final Color textColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color buttonColor;
  final Color backgroungIconColor;
  final Color lightBorderColor;
  final Color darkBorderColor;
  final Color remoteColor;
  final Color diseaseColor;
  final Color vacationColor;
  final Color studyColor;
  final Color otherColor;

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? textColor,
    Color? secondaryTextColor,
    Color? backgroundColor,
    Color? buttonColor,
    Color? backgroungIconColor,
    Color? lightBorderColor,
    Color? darkBorderColor,
    Color? remoteColor,
    Color? diseaseColor,
    Color? vacationColor,
    Color? studyColor,
    Color? otherColor,
  }) {
    return ThemeColors._(
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonColor: buttonColor ?? this.buttonColor,
      backgroungIconColor: backgroungIconColor ?? this.backgroungIconColor,
      lightBorderColor: lightBorderColor ?? this.lightBorderColor,
      darkBorderColor: darkBorderColor ?? this.darkBorderColor,
      remoteColor: remoteColor ?? this.remoteColor,
      diseaseColor: diseaseColor ?? this.diseaseColor,
      vacationColor: vacationColor ?? this.vacationColor,
      studyColor: studyColor ?? this.studyColor,
      otherColor: otherColor ?? this.otherColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors._(
      textColor: Color.lerp(
        textColor,
        other.textColor,
        t,
      )!,
      secondaryTextColor: Color.lerp(
        secondaryTextColor,
        other.secondaryTextColor,
        t,
      )!,
      backgroundColor: Color.lerp(
        backgroundColor,
        other.backgroundColor,
        t,
      )!,
      buttonColor: Color.lerp(
        buttonColor,
        other.buttonColor,
        t,
      )!,
      backgroungIconColor: Color.lerp(
        backgroungIconColor,
        other.backgroungIconColor,
        t,
      )!,
      lightBorderColor: Color.lerp(
        lightBorderColor,
        other.lightBorderColor,
        t,
      )!,
      darkBorderColor: Color.lerp(
        darkBorderColor,
        other.darkBorderColor,
        t,
      )!,
      remoteColor: Color.lerp(
        remoteColor,
        other.remoteColor,
        t,
      )!,
      diseaseColor: Color.lerp(
        diseaseColor,
        other.diseaseColor,
        t,
      )!,
      vacationColor: Color.lerp(
        vacationColor,
        other.vacationColor,
        t,
      )!,
      studyColor: Color.lerp(
        studyColor,
        other.studyColor,
        t,
      )!,
      otherColor: Color.lerp(
        otherColor,
        other.otherColor,
        t,
      )!,
    );
  }

  static ThemeColors of(BuildContext context) =>
      Theme.of(context).extension<ThemeColors>()!;
}
