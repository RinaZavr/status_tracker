import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/header_calendar_widget.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final GlobalKey<MonthViewState> state = GlobalKey<MonthViewState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MonthView(
        key: state,
        headerBuilder: (date) {
          return HeaderCalendarWidget(
            state: state,
            date: date,
          );
        },
      ),
    );
  }
}
