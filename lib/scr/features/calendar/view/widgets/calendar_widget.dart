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

  @override
  void initState() {
    final incidentNotPeriod = Incident(
      id: 0,
      userId: 0,
      name: 'test',
      surname: 'test',
      status: IncidentStatus.remote,
      isPeriod: false,
      date: DateTime.now().withoutTime.toString(),
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

    final incidentPeriod = Incident(
      id: 1,
      userId: 1,
      name: 'test',
      surname: 'test',
      status: IncidentStatus.sick,
      isPeriod: true,
      startDate: DateTime.now().withoutTime.toString(),
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
      ..add(eventPeriod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MonthView<Incident>(
        key: state,
        controller: controller,
        showBorder: false,
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
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ListRecordsScreen(
                date: date,
                events: events,
              );
            },
          );
        },
      ),
    );
  }
}
