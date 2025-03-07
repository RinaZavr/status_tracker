import 'package:flutter/material.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/config/styles/typography.dart';

@immutable
class ThemeTypography extends ThemeExtension<ThemeTypography> {
  const ThemeTypography._({
    required this.title,
    required this.titleMiddle,
    required this.normal,
  });

  ThemeTypography.light(
    BuildContext context, [
    Color color = AppColors.raisinblacksecond,
  ])  : title = AppTypography.nunitoBold20(context).copyWith(
          color: color,
        ),
        titleMiddle = AppTypography.nunitoBold18(context).copyWith(
          color: color,
        ),
        normal = AppTypography.nunitoRegular15(context).copyWith(
          color: color,
        );

  ThemeTypography.dark(
    BuildContext context, [
    Color color = AppColors.gainsboro,
  ])  : title = AppTypography.nunitoBold20(context).copyWith(
          color: color,
        ),
        titleMiddle = AppTypography.nunitoBold18(context).copyWith(
          color: color,
        ),
        normal = AppTypography.nunitoRegular15(context).copyWith(
          color: color,
        );

  final TextStyle title;
  final TextStyle titleMiddle;
  final TextStyle normal;

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
      titleMiddle: TextStyle.lerp(
        titleMiddle,
        other.titleMiddle,
        t,
      )!,
      normal: TextStyle.lerp(
        normal,
        other.normal,
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
    TextStyle? titleMiddle,
    TextStyle? normal,
  }) {
    return ThemeTypography._(
      title: title ?? this.title,
      titleMiddle: titleMiddle ?? this.titleMiddle,
      normal: normal ?? this.normal,
    );
  }
}
