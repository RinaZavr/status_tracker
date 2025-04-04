import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    super.key,
    this.selectedRange,
    required this.onChangedRange,
    this.isSingle,
  });

  final ValueChanged<DateTimeRange> onChangedRange;
  final DateTimeRange? selectedRange;
  final bool? isSingle;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: widget.isSingle == true
            ? CalendarDatePicker2Type.single
            : CalendarDatePicker2Type.range,
        weekdayLabels: [
          'Вс',
          'Пн',
          'Вт',
          'Ср',
          'Чт',
          'Пт',
          'Сб',
        ],
        firstDayOfWeek: 1,
        selectedDayHighlightColor: context.colorExt.buttonColor,
        selectedRangeHighlightColor: context.colorExt.buttonColor,
        dayTextStyle: context.textExt.normal,
        yearTextStyle: context.textExt.normal,
        monthTextStyle: context.textExt.normal,
        selectedDayTextStyle: context.textExt.normal,
        selectedRangeDayTextStyle: context.textExt.normal,
        weekdayLabelTextStyle: context.textExt.normal,
      ),
      value: widget.selectedRange != null
          ? widget.isSingle == true
              ? [widget.selectedRange!.start]
              : [
                  widget.selectedRange!.start,
                  widget.selectedRange!.end,
                ]
          : [],
      onValueChanged: (value) {
        if (widget.isSingle == true) {
          widget.onChangedRange(
            DateTimeRange(
              start: value.first,
              end: value.first,
            ),
          );
        } else if (value.length > 1) {
          widget.onChangedRange(
            DateTimeRange(
              start: value.first,
              end: value.last,
            ),
          );
        }
      },
    );
  }
}
