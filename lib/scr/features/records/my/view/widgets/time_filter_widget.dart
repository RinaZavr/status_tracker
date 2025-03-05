import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';
import 'package:status_tracker/scr/features/records/my/view/my_records_screen.dart';

class TimeFilterWidget extends StatefulWidget {
  const TimeFilterWidget({
    super.key,
    required this.onChangedFilter,
    required this.onChangedRange,
    required this.selectedRange,
    required this.selectedFilter,
  });

  final ValueChanged<TimeFilter> onChangedFilter;
  final ValueChanged<DateTimeRange> onChangedRange;
  final DateTimeRange? selectedRange;
  final TimeFilter selectedFilter;

  @override
  State<TimeFilterWidget> createState() => _TimeFilterWidgetState();
}

class _TimeFilterWidgetState extends State<TimeFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TimeFilter>(
      position: PopupMenuPosition.under,
      constraints: const BoxConstraints(
        maxWidth: 350,
      ),
      onSelected: (value) {
        setState(() {
          widget.onChangedFilter(value);
          widget.onChangedRange(Utils.updateSelectedRange(value));
        });
      },
      color: context.colorExt.backgroundColor,
      itemBuilder: (context) {
        return TimeFilter.values.map((item) {
          return PopupMenuItem(
            value: item,
            child: Center(
              child: item == TimeFilter.period
                  ? SizedBox(
                      width: 350,
                      child: CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.range,
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
                          selectedDayHighlightColor:
                              context.colorExt.buttonColor,
                          selectedRangeHighlightColor:
                              context.colorExt.buttonColor,
                          dayTextStyle: context.textExt.normal,
                          yearTextStyle: context.textExt.normal,
                          monthTextStyle: context.textExt.normal,
                          selectedDayTextStyle: context.textExt.normal,
                          selectedRangeDayTextStyle: context.textExt.normal,
                          weekdayLabelTextStyle: context.textExt.normal,
                        ),
                        value: widget.selectedRange != null
                            ? [
                                widget.selectedRange!.start,
                                widget.selectedRange!.end,
                              ]
                            : [],
                        onValueChanged: (value) {
                          if (value.length > 1) {
                            final possibleFilter = Utils.getFilterFromRange(
                              DateTimeRange(
                                start: value.first.withoutTime,
                                end: value.last.withoutTime,
                              ),
                            );
                            widget.onChangedFilter(possibleFilter);

                            widget.onChangedRange(
                              DateTimeRange(
                                start: value.first,
                                end: value.last,
                              ),
                            );
                            context.pop();
                          }
                        },
                      ),
                    )
                  : Text(
                      item.name,
                      style: context.textExt.normal,
                    ),
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: context.colorExt.lightBorderColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Icon(
              AppIcons.filterIcon,
              color: context.colorExt.textColor,
            ),
            Text(
              widget.selectedFilter.name,
              style: context.textExt.normal,
            ),
          ],
        ),
      ),
    );
  }
}
