import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/incident_event_widget.dart';

class CellCalendarWidget extends StatefulWidget {
  const CellCalendarWidget({
    super.key,
    required this.date,
    required this.events,
    required this.isToday,
    required this.isInMonth,
  });

  final DateTime date;
  final List<CalendarEventData<Incident>> events;
  final bool isToday;
  final bool isInMonth;

  @override
  State<CellCalendarWidget> createState() => _CellCalendarWidgetState();
}

class _CellCalendarWidgetState extends State<CellCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.isToday
            ? context.colorExt.darkBorderColor.withAlpha(70)
            : null,
        border: Border.all(
          color: widget.isInMonth
              ? context.colorExt.darkBorderColor
              : context.colorExt.lightBorderColor,
        ),
      ),
      child: widget.isInMonth
          ? Column(
              spacing: 2,
              children: [
                Text(
                  widget.date.day.toString(),
                  style: context.textExt.normal,
                ),
                if (widget.events.isNotEmpty)
                  IncidentEventWidget(
                    event: widget.events[0],
                    isSmall: true,
                  ),
                const Spacer(),
                if (widget.events.isNotEmpty && widget.events.length > 1)
                  Text(
                    '+${widget.events.length - 1}',
                    style: context.textExt.normal,
                  ),
              ],
            )
          : null,
    );
  }
}

enum IncidentStatus {
  remote('Удаленно'),
  sick('Болезнь'),
  vacation('Отпуск'),
  study('Учеба'),
  other('Другое');

  const IncidentStatus(this.name);
  final String name;

  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}

class Incident {
  Incident({
    required this.id,
    required this.userId,
    required this.name,
    required this.surname,
    required this.status,
    this.date,
    required this.isPeriod,
    this.startDate,
    this.endDate,
  });

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        surname: json['surname'],
        status: IncidentStatus.values
            .where((element) => element.toShortString() == json['status'])
            .first,
        date: json['date'],
        isPeriod: json['isPeriod'],
        startDate: json['startDate'],
        endDate: json['endDate'],
      );

  int id;
  int userId;
  String name;
  String surname;
  IncidentStatus status;
  String? date;
  bool isPeriod;
  String? startDate;
  String? endDate;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'surname': surname,
        'status': status.toShortString(),
        'date': date,
        'isPeriod': isPeriod,
        'startDate': startDate,
        'endDate': endDate,
      };
}
