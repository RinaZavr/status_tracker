import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/calendar_button.dart';

class HeaderCalendarWidget extends StatefulWidget {
  const HeaderCalendarWidget({
    super.key,
    required this.state,
    required this.date,
  });

  final GlobalKey<MonthViewState> state;
  final DateTime date;

  @override
  State<HeaderCalendarWidget> createState() => _HeaderCalendarWidgetState();
}

class _HeaderCalendarWidgetState extends State<HeaderCalendarWidget> {
  String headerText = '';
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    headerText = _getHeader(
      date: currentDate,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CalendarButton(
          icon: AppIcons.monthBackIcon,
          onPressed: () {
            widget.state.currentState?.previousPage();
            currentDate = addMonth(currentDate);
            headerText = _getHeader(
              date: currentDate,
            );
            setState(() {});
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              headerText,
              style: context.textExt.titleMiddle,
            ),
          ),
        ),
        CalendarButton(
          icon: AppIcons.monthReturnIcon,
          onPressed: widget.state.currentState?.currentDate.month ==
                  DateTime.now().month
              ? null
              : () {
                  widget.state.currentState?.jumpToMonth(DateTime.now());
                },
        ),
        CalendarButton(
          icon: AppIcons.monthForwardIcon,
          onPressed: () {
            widget.state.currentState?.nextPage();
            currentDate = subtractMonth(currentDate);
            headerText = _getHeader(
              date: currentDate,
            );
          },
        ),
      ],
    );
  }

  String _getHeader({
    required DateTime date,
  }) {
    final monthNames = <String>[
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];

    final monthIndex = date.month - 1; // Индекс месяца (от 0 до 11)
    final monthName = monthNames[monthIndex];

    return '$monthName ${date.year}';
  }

  DateTime addMonth(DateTime date) {
    // Прибавляем 1 месяц
    var newMonth = date.month + 1;
    var newYear = date.year;

    // Если месяц больше 12, переходим на следующий год
    if (newMonth > 12) {
      newMonth = 1;
      newYear += 1;
    }

    // Возвращаем новую дату
    return DateTime(newYear, newMonth, date.day);
  }

  DateTime subtractMonth(DateTime date) {
    // Вычитаем 1 месяц
    var newMonth = date.month - 1;
    var newYear = date.year;

    // Если месяц меньше 1, переходим на предыдущий год
    if (newMonth < 1) {
      newMonth = 12;
      newYear -= 1;
    }

    // Возвращаем новую дату
    return DateTime(newYear, newMonth, date.day);
  }
}
