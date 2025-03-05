import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/cell_calendar_widget.dart';
import 'package:status_tracker/scr/features/records/my/view/widgets/incident_status_widget.dart';
import 'package:status_tracker/scr/features/records/my/view/widgets/time_filter_widget.dart';

class MyRecordsScreen extends StatefulWidget {
  const MyRecordsScreen({super.key});

  @override
  State<MyRecordsScreen> createState() => _MyRecordsScreenState();
}

class _MyRecordsScreenState extends State<MyRecordsScreen> {
  TimeFilter _selectedValue = TimeFilter.month;
  DateTimeRange? _selectedRange;
  final List<IncidentStatus> _selectedStatuses = List.of(IncidentStatus.values);

  bool sortDown = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Журнал записей',
            style: context.textExt.title,
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(AppIcons.closeIcon),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  TimeFilterWidget(
                    onChangedFilter: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                    onChangedRange: (value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                    selectedRange: _selectedRange,
                    selectedFilter: _selectedValue,
                  ),
                  if (_selectedRange != null &&
                      _selectedValue != TimeFilter.all)
                    Text(
                      '${DateFormat('dd.MM.yyyy').format(_selectedRange!.start)} '
                      '- ${DateFormat('dd.MM.yyyy').format(_selectedRange!.end)}',
                      style: context.textExt.titleMiddle,
                    ),
                  CustomButton(
                    onPressed: () {
                      setState(() {
                        sortDown = !sortDown;
                      });
                    },
                    child: Icon(
                      sortDown ? AppIcons.sortUpIcon : AppIcons.sortDownIcon,
                      color: context.colorExt.textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final currentStatus = IncidentStatus.values[index];

                    return IncidentStatusWidget(
                      status: currentStatus,
                      isSelected: _selectedStatuses.contains(currentStatus),
                      onTap: () {
                        setState(() {
                          if (_selectedStatuses.contains(currentStatus)) {
                            _selectedStatuses.remove(currentStatus);
                          } else {
                            _selectedStatuses.add(currentStatus);
                          }
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: IncidentStatus.values.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum TimeFilter {
  day('Текущий день'),
  week('Текущая неделя'),
  month('Текущий месяц'),
  year('Текущий год'),
  all('Все'),
  period('Произвольный период');

  const TimeFilter(this.name);
  final String name;
}
