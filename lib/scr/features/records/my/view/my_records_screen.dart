import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/features/records/create/view/create_record_screen.dart';
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
  List<CalendarEventData<Incident>> events = [];

  bool sortDown = false;

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
      name: 'Веревкин',
      surname: 'Константин',
      status: IncidentStatus.sick,
      isPeriod: true,
      startDate: DateTime(2025, 3, 5).withoutTime.toString(),
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

    final incidentPeriod1 = Incident(
      id: 1,
      userId: 1,
      name: 'Веревкин',
      surname: 'Константин',
      status: IncidentStatus.sick,
      isPeriod: true,
      startDate: DateTime(2025, 2, 6).withoutTime.toString(),
      endDate: DateTime(2025, 3, 10).withoutTime.toString(),
    );
    final eventPeriod1 = CalendarEventData<Incident>(
      title: incidentPeriod1.name + incidentPeriod1.surname,
      date: DateTime.parse(incidentPeriod1.date ?? incidentPeriod1.startDate!),
      endDate: incidentPeriod1.endDate == null
          ? null
          : DateTime.parse(incidentPeriod1.endDate!),
      event: incidentPeriod1,
    );

    events = [eventNotPeriod, eventPeriod, eventPeriod1];

    super.initState();
  }

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
                      '${Utils.getBasicDateFormat(dateTime: _selectedRange!.start)} '
                      '- ${Utils.getBasicDateFormat(dateTime: _selectedRange!.end)}',
                      style: context.textExt.titleMiddle,
                    ),
                  CustomButton(
                    onPressed: () {
                      setState(() {
                        sortDown = !sortDown;
                        if (sortDown) {
                          events.sort(Utils.sortEventsAscending);
                        } else {
                          events.sort(Utils.sortEventsDescending);
                        }
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
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    final event = events[index].event!;
                    final statusUi = Utils.getStatusUi(context, event.status);
                    var text = '';
                    var range = <DateTime>[];
                    if (event.date != null) {
                      text = Utils.getBasicDateFormat(date: event.date);
                      range = [
                        DateTime.parse(event.date!),
                        DateTime.parse(event.date!),
                      ];
                    } else if (event.startDate != null &&
                        event.endDate != null) {
                      text =
                          '${Utils.getBasicDateFormat(date: event.startDate)} '
                          '- ${Utils.getBasicDateFormat(date: event.endDate)}';
                      range = [
                        DateTime.parse(event.startDate!),
                        DateTime.parse(event.endDate!),
                      ];
                    }

                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorExt.lightBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: statusUi['color'],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 8,
                              children: [
                                Icon(
                                  statusUi['icon'],
                                  size: 20,
                                ),
                                Text(
                                  text,
                                  style: context.textExt.normal,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CreateRecordScreen(
                                    dates: range,
                                    status: event.status,
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              AppIcons.editIcon,
                              color: context.colorExt.textColor,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                events.remove(events[index]);
                              });
                            },
                            icon: Icon(
                              AppIcons.closeIcon,
                              color: context.colorExt.textColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: events.length,
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
