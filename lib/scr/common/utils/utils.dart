import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/features/records/my/view/my_records_screen.dart';

abstract class Utils {
  Utils._();

  static Map<String, dynamic> getStatusUi(
    BuildContext context,
    IncidentStatus status,
  ) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case IncidentStatus.remote:
        statusColor = context.colorExt.remoteColor;
        statusIcon = AppIcons.remoteIcon;
        break;
      case IncidentStatus.sick:
        statusColor = context.colorExt.sickColor;
        statusIcon = AppIcons.sickIcon;
        break;
      case IncidentStatus.vacation:
        statusColor = context.colorExt.vacationColor;
        statusIcon = AppIcons.vacationIcon;
        break;
      case IncidentStatus.study:
        statusColor = context.colorExt.studyColor;
        statusIcon = AppIcons.studyIcon;
        break;
      case IncidentStatus.other:
        statusColor = context.colorExt.otherColor;
        statusIcon = AppIcons.otherIcon;
        break;
    }
    return {'color': statusColor, 'icon': statusIcon};
  }

  static DateTimeRange updateSelectedRange(TimeFilter filter) {
    final now = DateTime.now().withoutTime;
    var startDate = now;
    var endDate = now;

    switch (filter) {
      case TimeFilter.day:
        startDate = DateTime(now.year, now.month, now.day);
        endDate = startDate
            .add(const Duration(days: 1))
            .subtract(const Duration(seconds: 1));
        break;
      case TimeFilter.week:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = startDate
            .add(const Duration(days: 7))
            .subtract(const Duration(seconds: 1));
        break;
      case TimeFilter.month:
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 1)
            .subtract(const Duration(seconds: 1));
        break;
      case TimeFilter.year:
        startDate = DateTime(now.year, 1, 1);
        endDate =
            DateTime(now.year + 1, 1, 1).subtract(const Duration(seconds: 1));
        break;
      case TimeFilter.all:
        break;
      case TimeFilter.period:
        break;
    }
    return DateTimeRange(
      start: startDate.withoutTime,
      end: endDate.withoutTime,
    );
  }

  static TimeFilter getFilterFromRange(DateTimeRange range) {
    final now = DateTime.now().withoutTime;

    // Проверяем, совпадает ли период с текущим днем
    final dayRange = DateTimeRange(
      start: DateTime(now.year, now.month, now.day).withoutTime,
      end: DateTime(now.year, now.month, now.day)
          .add(const Duration(days: 1))
          .subtract(const Duration(seconds: 1))
          .withoutTime,
    );
    if (range.start == dayRange.start && range.end == dayRange.end) {
      return TimeFilter.day;
    }

    // Проверяем, совпадает ли период с текущей неделей
    final weekStart = now.subtract(Duration(days: now.weekday - 1)).withoutTime;
    final weekRange = DateTimeRange(
      start: weekStart,
      end: weekStart
          .add(const Duration(days: 7))
          .subtract(const Duration(seconds: 1))
          .withoutTime,
    );
    if (range.start == weekRange.start && range.end == weekRange.end) {
      return TimeFilter.week;
    }

    // Проверяем, совпадает ли период с текущим месяцем
    final monthRange = DateTimeRange(
      start: DateTime(now.year, now.month, 1).withoutTime,
      end: DateTime(now.year, now.month + 1, 1)
          .subtract(const Duration(seconds: 1))
          .withoutTime,
    );
    if (range.start == monthRange.start && range.end == monthRange.end) {
      return TimeFilter.month;
    }

    // Проверяем, совпадает ли период с текущим годом
    final yearRange = DateTimeRange(
      start: DateTime(now.year, 1, 1).withoutTime,
      end: DateTime(now.year + 1, 1, 1)
          .subtract(const Duration(seconds: 1))
          .withoutTime,
    );
    if (range.start == yearRange.start && range.end == yearRange.end) {
      return TimeFilter.year;
    }

    // Если период не совпадает ни с одним из фильтров,
    // возвращаем "Произвольный период"
    return TimeFilter.period;
  }

  static String getBasicDateFormat({String? date, DateTime? dateTime}) {
    if (date != null) {
      return DateFormat('dd.MM.yyyy').format(DateTime.parse(date));
    } else if (dateTime != null) {
      return DateFormat('dd.MM.yyyy').format(dateTime);
    }
    return '';
  }

  static int sortEventsAscending(
    CalendarEventData<Incident> event1,
    CalendarEventData<Incident> event2,
  ) {
    // Преобразуем строки дат в объекты DateTime для корректного сравнения
    final dateA = event1.event?.date != null
        ? DateTime.tryParse(event1.event!.date!)
        : null;
    final startDateA = event1.event?.startDate != null
        ? DateTime.tryParse(event1.event!.startDate!)
        : null;
    final dateB = event2.event?.date != null
        ? DateTime.tryParse(event2.event!.date!)
        : null;
    final startDateB = event2.event?.startDate != null
        ? DateTime.tryParse(event2.event!.startDate!)
        : null;

    // Если обе даты присутствуют у обоих событий, сравниваем их
    if (dateA != null && dateB != null) {
      return dateA.compareTo(dateB);
    } else if (dateA != null && startDateB != null) {
      return dateA.compareTo(startDateB);
    } else if (startDateA != null && dateB != null) {
      return startDateA.compareTo(dateB);
    } else if (startDateA != null && startDateB != null) {
      return startDateA.compareTo(startDateB);
    } else {
      // Если все даты отсутствуют, считаем события равными
      return 0;
    }
  }

  static int sortEventsDescending(
    CalendarEventData<Incident> event1,
    CalendarEventData<Incident> event2,
  ) {
    // Преобразуем строки дат в объекты DateTime для корректного сравнения
    final dateA = event1.event?.date != null
        ? DateTime.tryParse(event1.event!.date!)
        : null;
    final startDateA = event1.event?.startDate != null
        ? DateTime.tryParse(event1.event!.startDate!)
        : null;
    final dateB = event2.event?.date != null
        ? DateTime.tryParse(event2.event!.date!)
        : null;
    final startDateB = event2.event?.startDate != null
        ? DateTime.tryParse(event2.event!.startDate!)
        : null;

    // Сравниваем даты по убыванию
    if (dateA != null && dateB != null) {
      return dateB.compareTo(dateA);
    } else if (dateA != null && startDateB != null) {
      return startDateB.compareTo(dateA);
    } else if (startDateA != null && dateB != null) {
      return dateB.compareTo(startDateA);
    } else if (startDateA != null && startDateB != null) {
      return startDateB.compareTo(startDateA);
    } else {
      // Если все даты отсутствуют, считаем события равными
      return 0;
    }
  }
}
