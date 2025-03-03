import 'package:flutter/material.dart';

@immutable
class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors._({
    required this.accentColor,
    required this.primaryColor,
  });

  const ThemeColors.light()
      : accentColor = Colors.white,
        primaryColor = Colors.black;

  const ThemeColors.dark()
      : accentColor = Colors.black,
        primaryColor = Colors.white;

  final Color accentColor;
  final Color primaryColor;

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? accentColor,
    Color? primaryColor,
  }) {
    return ThemeColors._(
      accentColor: accentColor ?? this.accentColor,
      primaryColor: primaryColor ?? this.primaryColor,
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
      accentColor: Color.lerp(
        accentColor,
        other.accentColor,
        t,
      )!,
      primaryColor: Color.lerp(
        primaryColor,
        other.primaryColor,
        t,
      )!,
    );
  }

  static ThemeColors of(BuildContext context) =>
      Theme.of(context).extension<ThemeColors>()!;
}
