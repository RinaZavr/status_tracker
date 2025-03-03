import 'package:flutter/material.dart';

@immutable
class ThemeTypography extends ThemeExtension<ThemeTypography> {
  const ThemeTypography._({
    required this.title,
  });

  ThemeTypography.light([Color color = Colors.black])
      : title = const TextStyle().copyWith(
          color: color,
        );

  ThemeTypography.dark([Color color = Colors.white])
      : title = const TextStyle().copyWith(
          color: color,
        );

  final TextStyle title;

  @override
  ThemeExtension<ThemeTypography> lerp(
    ThemeExtension<ThemeTypography>? other,
    double t,
  ) {
    if (other is! ThemeTypography) {
      return this;
    }

    return ThemeTypography._(
      title: TextStyle.lerp(
        title,
        other.title,
        t,
      )!,
    );
  }

  static ThemeTypography of(BuildContext context) {
    return Theme.of(context).extension<ThemeTypography>()!;
  }

  @override
  ThemeExtension<ThemeTypography> copyWith({
    TextStyle? title,
  }) {
    return ThemeTypography._(
      title: title ?? this.title,
    );
  }
}
