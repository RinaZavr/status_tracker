import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';
import 'package:status_tracker/scr/features/records/my/view/my_records_screen.dart';
import 'package:status_tracker/scr/features/records/my/view/widgets/date_picker_widget.dart';

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
                      child: DatePickerWidget(
                        selectedRange: widget.selectedRange,
                        onChangedRange: (range) {
                          final possibleFilter = Utils.getFilterFromRange(
                            DateTimeRange(
                              start: range.start.withoutTime,
                              end: range.end.withoutTime,
                            ),
                          );
                          widget.onChangedFilter(possibleFilter);
                          widget.onChangedRange(range);
                          context.pop();
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
