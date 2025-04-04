import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/calendar_button.dart';

class HeaderCalendarWidget extends StatelessWidget {
  const HeaderCalendarWidget({
    super.key,
    required this.currentDate,
    required this.onTapPrevious,
    required this.onTapNext,
    required this.onTapReset,
  });

  final DateTime currentDate;
  final VoidCallback onTapPrevious;
  final VoidCallback onTapNext;
  final VoidCallback onTapReset;

  @override
  Widget build(BuildContext context) {
    final month =
        DateFormat.MMMM('ru_RU').format(currentDate).capitalizeFirstLetter();
    final year = currentDate.year;
    return Row(
      spacing: 8,
      children: [
        CalendarButton(
          icon: AppIcons.monthBackIcon,
          onPressed: onTapPrevious,
        ),
        Expanded(
          child: Center(
            child: Text(
              '$month $year',
              style: context.textExt.titleMiddle,
            ),
          ),
        ),
        CalendarButton(
          icon: AppIcons.monthReturnIcon,
          onPressed:
              currentDate.month == DateTime.now().month ? null : onTapReset,
        ),
        CalendarButton(
          icon: AppIcons.monthForwardIcon,
          onPressed: onTapNext,
        ),
      ],
    );
  }
}
