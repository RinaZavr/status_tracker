import 'package:api/api_client.dart';
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
  bool isFirstBuild = true; // Флаг для отслеживания первого рендера

  List<Key> eventKeys = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.isToday && widget.isInMonth
                ? context.colorExt.darkBorderColor.withAlpha(70)
                : null,
            border: Border.all(
              color: widget.isInMonth
                  ? context.colorExt.darkBorderColor
                  : context.colorExt.lightBorderColor,
            ),
          ),
          child: widget.isInMonth
              ? widget.events.isEmpty
                  ? Column(
                      children: [
                        Text(
                          widget.date.day.toString(),
                          style: context.textExt.normal,
                        ),
                      ],
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        const double spacing = 2;

                        // Высота заголовка с датой
                        final headerHeight = _getTextHeight(
                          widget.date.day.toString(),
                          context.textExt.normal,
                          constraints.maxWidth,
                        );

                        // Высота текста "+N"
                        final moreText = '+${widget.events.length}';
                        final moreTextHeight = _getTextHeight(
                          moreText,
                          context.textExt.normal,
                          constraints.maxWidth,
                        );

                        // Доступная высота для событий
                        var availableHeight = constraints.maxHeight -
                            headerHeight -
                            spacing -
                            moreTextHeight;

                        final eventWidgets = <Widget>[];
                        double usedHeight = 0;
                        double eventHeight = 0;

                        for (var i = 0; i < widget.events.length; i++) {
                          final eventWidget = Padding(
                            padding: const EdgeInsets.only(
                              bottom: spacing,
                            ),
                            child: IncidentEventWidget(
                              event: widget.events[i],
                              isSmall: true,
                            ),
                          );
                          eventHeight = _getTextHeight(
                                '${widget.events[i].event!.name[0]}'
                                '${widget.events[i].event!.surname[0]}',
                                context.textExt.normal,
                                constraints.maxWidth,
                              ) +
                              spacing +
                              6;
                          if (i == widget.events.length - 1) {
                            availableHeight += moreTextHeight;
                          }
                          if (usedHeight + eventHeight > availableHeight) {
                            break;
                          } else {
                            eventWidgets.add(eventWidget);
                            usedHeight += eventHeight;
                          }
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min, // Фиксируем высоту
                          children: [
                            Text(
                              widget.date.day.toString(),
                              style: context.textExt.normal,
                            ),
                            const SizedBox(height: spacing),
                            ...eventWidgets,
                            const Spacer(),
                            if (eventWidgets.length < widget.events.length)
                              Text(
                                '+'
                                '${widget.events.length - eventWidgets.length}',
                                style: context.textExt.normal,
                              ),
                          ],
                        );
                      },
                    )
              : null,
        );
      },
    );
  }

  /// Вычисление высоты текста с учетом ширины контейнера и переноса строк
  double _getTextHeight(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.height;
  }
}

// enum IncidentStatus {
//   remote('Удаленно'),
//   sick('Болезнь'),
//   vacation('Отпуск'),
//   study('Учеба'),
//   other('Другое');

//   const IncidentStatus(this.name);
//   final String name;

//   String toShortString() {
//     return toString().split('.').last.toUpperCase();
//   }
// }

// class Incident {
//   Incident({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.surname,
//     required this.status,
//     this.date,
//     required this.isPeriod,
//     this.startDate,
//     this.endDate,
//   });

//   factory Incident.fromJson(Map<String, dynamic> json) => Incident(
//         id: json['id'],
//         userId: json['userId'],
//         name: json['name'],
//         surname: json['surname'],
//         status: IncidentStatus.values
//             .where((element) => element.toShortString() == json['status'])
//             .first,
//         date: json['date'],
//         isPeriod: json['isPeriod'],
//         startDate: json['startDate'],
//         endDate: json['endDate'],
//       );

//   int id;
//   int userId;
//   String name;
//   String surname;
//   IncidentStatus status;
//   String? date;
//   bool isPeriod;
//   String? startDate;
//   String? endDate;

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'userId': userId,
//         'name': name,
//         'surname': surname,
//         'status': status.toShortString(),
//         'date': date,
//         'isPeriod': isPeriod,
//         'startDate': startDate,
//         'endDate': endDate,
//       };
// }
