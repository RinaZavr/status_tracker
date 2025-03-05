import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';

class WeekdayCalendarWidget extends StatelessWidget {
  const WeekdayCalendarWidget({super.key, required this.day});

  final int day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          getDayOfWeek(day),
          style: context.textExt.normal,
        ),
      ),
    );
  }

  String getDayOfWeek(int day) {
    final daysOfWeek = <String>[
      'Пн',
      'Вт',
      'Ср',
      'Чт',
      'Пт',
      'Сб',
      'Вс',
    ];

    return daysOfWeek[day];
  }
}
