import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:status_tracker/main.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/config/styles/cubit/theme_cubit.dart';

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

  static DateTimeRange updateSelectedRange(PeriodName filter) {
    final now = DateTime.now().withoutTime;
    var startDate = now;
    var endDate = now;

    switch (filter) {
      case PeriodName.day:
        startDate = DateTime(now.year, now.month, now.day);
        endDate = startDate
            .add(const Duration(days: 1))
            .subtract(const Duration(seconds: 1));
        break;
      case PeriodName.week:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = startDate
            .add(const Duration(days: 7))
            .subtract(const Duration(seconds: 1));
        break;
      case PeriodName.month:
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 1)
            .subtract(const Duration(seconds: 1));
        break;
      case PeriodName.year:
        startDate = DateTime(now.year, 1, 1);
        endDate =
            DateTime(now.year + 1, 1, 1).subtract(const Duration(seconds: 1));
        break;
      case PeriodName.all:
        break;
      case PeriodName.period:
        break;
    }
    return DateTimeRange(
      start: startDate.withoutTime,
      end: endDate.withoutTime,
    );
  }

  static PeriodName getFilterFromRange(DateTimeRange range) {
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
      return PeriodName.day;
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
      return PeriodName.week;
    }

    // Проверяем, совпадает ли период с текущим месяцем
    final monthRange = DateTimeRange(
      start: DateTime(now.year, now.month, 1).withoutTime,
      end: DateTime(now.year, now.month + 1, 1)
          .subtract(const Duration(seconds: 1))
          .withoutTime,
    );
    if (range.start == monthRange.start && range.end == monthRange.end) {
      return PeriodName.month;
    }

    // Проверяем, совпадает ли период с текущим годом
    final yearRange = DateTimeRange(
      start: DateTime(now.year, 1, 1).withoutTime,
      end: DateTime(now.year + 1, 1, 1)
          .subtract(const Duration(seconds: 1))
          .withoutTime,
    );
    if (range.start == yearRange.start && range.end == yearRange.end) {
      return PeriodName.year;
    }

    // Если период не совпадает ни с одним из фильтров,
    // возвращаем "Произвольный период"
    return PeriodName.period;
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
    Incident event1,
    Incident event2,
  ) {
    // Преобразуем строки дат в объекты DateTime для корректного сравнения
    final dateA = event1.date != null ? DateTime.tryParse(event1.date!) : null;
    final startDateA =
        event1.startDate != null ? DateTime.tryParse(event1.startDate!) : null;
    final dateB = event2.date != null ? DateTime.tryParse(event2.date!) : null;
    final startDateB =
        event2.startDate != null ? DateTime.tryParse(event2.startDate!) : null;

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
    Incident event1,
    Incident event2,
  ) {
    // Преобразуем строки дат в объекты DateTime для корректного сравнения
    final dateA = event1.date != null ? DateTime.tryParse(event1.date!) : null;
    final startDateA =
        event1.startDate != null ? DateTime.tryParse(event1.startDate!) : null;
    final dateB = event2.date != null ? DateTime.tryParse(event2.date!) : null;
    final startDateB =
        event2.startDate != null ? DateTime.tryParse(event2.startDate!) : null;

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

  static void showSnackBar({
    required String title,
    required String message,
    bool? isError,
  }) {
    final isDark =
        scaffoldMessengerKey.currentContext?.read<ThemeCubit>().state.isDark ==
            true;
    var backgroundColor = AppColors.raisinblack;
    var iconColor = AppColors.gainsboro;
    final textColor =
        isDark == true ? AppColors.gainsboro : AppColors.raisinblack;

    var icon = CupertinoIcons.check_mark_circled;

    if (isError == true) {
      icon = CupertinoIcons.exclamationmark_circle;

      if (isDark) {
        backgroundColor = AppColors.cerise;
        iconColor = AppColors.paradisePink;
      } else {
        backgroundColor = AppColors.electricCrimson;
        iconColor = AppColors.crimsonGlory;
      }
    } else {
      icon = CupertinoIcons.check_mark_circled;

      if (isDark) {
        backgroundColor = AppColors.oceanGreen;
        iconColor = AppColors.greenSheen;
      } else {
        backgroundColor = AppColors.mediumSeaGreen;
        iconColor = AppColors.seaGreen;
      }
    }

    final messageTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: textColor,
    );

    final titleTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: textColor,
    );

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(milliseconds: 1500),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            spacing: 16,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleTextStyle,
                  ),
                  Text(
                    message,
                    style: messageTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalizeFirstLetter() {
    if (this == null || isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
