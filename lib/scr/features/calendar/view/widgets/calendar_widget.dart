import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/cell_calendar_widget.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/header_calendar_widget.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/weekday_calendar_widget.dart';
import 'package:status_tracker/scr/features/records/list/view/list_records_screen.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final GlobalKey<MonthViewState> state = GlobalKey<MonthViewState>();
  final EventController<Incident> controller = EventController<Incident>();

  DateTime _currentDate =
      DateTime.now(); // Текущая дата для отслеживания месяца

  @override
  void initState() {
    final incidentNotPeriod = Incident(
      id: 0,
      userId: 0,
      name: 'Веревкин',
      surname: 'Константин',
      status: IncidentStatus.remote,
      isPeriod: false,
      date: DateTime(2025, 3, 5).withoutTime.toString(),
    );
    final eventNotPeriod = CalendarEventData<Incident>(
      title: incidentNotPeriod.name + incidentNotPeriod.surname,
      date: DateTime.parse(
        incidentNotPeriod.date ?? incidentNotPeriod.startDate!,
      ),
      endDate: incidentNotPeriod.endDate == null
          ? null
          : DateTime.parse(incidentNotPeriod.endDate!),
      event: incidentNotPeriod,
    );

    final incidentPeriod1 = Incident(
      id: 1,
      userId: 1,
      name: 'Ж',
      surname: 'Ш',
      status: IncidentStatus.sick,
      isPeriod: true,
      startDate: DateTime(2025, 3, 5).withoutTime.toString(),
      endDate: DateTime(2025, 3, 10).withoutTime.toString(),
    );
    final eventPeriod1 = CalendarEventData<Incident>(
      title: incidentPeriod1.name + incidentPeriod1.surname,
      date: DateTime.parse(incidentPeriod1.date ?? incidentPeriod1.startDate!),
      endDate: incidentPeriod1.endDate == null
          ? null
          : DateTime.parse(incidentPeriod1.endDate!),
      event: incidentPeriod1,
    );

    final incidentPeriod = Incident(
      id: 1,
      userId: 1,
      name: 'Веревкин',
      surname: 'Константин',
      status: IncidentStatus.sick,
      isPeriod: true,
      startDate: DateTime(2025, 3, 5).withoutTime.toString(),
      endDate: DateTime(2025, 3, 10).withoutTime.toString(),
    );
    final eventPeriod = CalendarEventData<Incident>(
      title: incidentPeriod.name + incidentPeriod.surname,
      date: DateTime.parse(incidentPeriod.date ?? incidentPeriod.startDate!),
      endDate: incidentPeriod.endDate == null
          ? null
          : DateTime.parse(incidentPeriod.endDate!),
      event: incidentPeriod,
    );

    controller
      ..add(eventNotPeriod)
      ..add(eventPeriod)
      ..add(eventPeriod1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weeksInMonth = _getWeeksInMonth(_currentDate);

    // Доступная высота календаря
    final availableHeight = MediaQuery.of(context).size.height * 3 / 4;

    // Рассчитываем cellAspectRatio
    final cellAspectRatio = _calculateCellAspectRatio(
      availableHeight,
      weeksInMonth,
      MediaQuery.of(context).size.width,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MonthView<Incident>(
        key: state,
        controller: controller,
        showBorder: false,
        hideDaysNotInMonth: true,
        cellAspectRatio: cellAspectRatio,
        headerBuilder: (date) {
          return HeaderCalendarWidget(
            state: state,
            date: date,
          );
        },
        weekDayBuilder: (day) {
          return WeekdayCalendarWidget(
            day: day,
          );
        },
        cellBuilder: (date, events, isToday, isInMonth, hideDaysNotInMonth) {
          return CellCalendarWidget(
            date: date,
            events: events,
            isToday: isToday,
            isInMonth: isInMonth,
          );
        },
        onCellTap: (events, date) {
          if (date.month == state.currentState!.currentDate.month) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListRecordsScreen(
                  date: date,
                  events: events,
                );
              },
            );
          }
        },
        onPageChange: (date, direction) {
          // Обновляем состояние при изменении месяца
          setState(() {
            _currentDate = date;
          });
        },
      ),
    );
  }

  // Функция для расчета количества недель в месяце
  int _getWeeksInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    // Количество дней в месяце
    final daysInMonth = lastDayOfMonth.day;

    // Номер дня недели для первого дня месяца
    // (1 = понедельник, 7 = воскресенье)
    final firstWeekday = firstDayOfMonth.weekday;

    // Количество недель
    return ((daysInMonth + firstWeekday - 1) / 7).ceil();
  }

  // Функция для расчета cellAspectRatio
  double _calculateCellAspectRatio(
    double availableHeight,
    int weeksInMonth,
    double screenWidth,
  ) {
    // Ширина ячейки = ширина экрана / 7 (7 дней в неделе)
    final cellWidth = screenWidth / 7;

    // Высота ячейки = доступная высота / количество недель
    final cellHeight = availableHeight / weeksInMonth;

    // cellAspectRatio = ширина ячейки / высота ячейки
    return cellWidth / cellHeight;
  }
}
