import 'package:api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/features/incidents/create/view/create_record_screen.dart';
import 'package:status_tracker/scr/features/incidents/cubit/incidents_cubit.dart';
import 'package:status_tracker/scr/features/incidents/my/view/widgets/incident_status_widget.dart';
import 'package:status_tracker/scr/features/incidents/my/view/widgets/time_filter_widget.dart';

class MyRecordsScreen extends StatefulWidget {
  const MyRecordsScreen({super.key});

  @override
  State<MyRecordsScreen> createState() => _MyRecordsScreenState();
}

class _MyRecordsScreenState extends State<MyRecordsScreen> {
  PeriodName _selectedValue = PeriodName.month;
  DateTimeRange? _selectedRange;
  final List<IncidentStatus> _selectedStatuses = List.of(IncidentStatus.values);
  List<Incident> events = [];

  bool sortDown = false;

  bool needUpdateCalendar = false;

  @override
  void initState() {
    _getIncidents();

    super.initState();
  }

  void _getIncidents() {
    context.read<IncidentsCubit>().getIncidents(
          period: _selectedValue,
          startDate: _selectedValue == PeriodName.period
              ? _selectedRange?.start
              : null,
          endDate:
              _selectedValue == PeriodName.period ? _selectedRange?.end : null,
          statuses: _selectedStatuses,
        );
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
                context.pop(needUpdateCalendar);
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
                    onChanged: (filter, range) {
                      setState(() {
                        _selectedValue = filter;
                      });
                      if (range != null) {
                        setState(() {
                          _selectedRange = range;
                        });
                      }
                      _getIncidents();
                    },
                    selectedRange: _selectedRange,
                    selectedFilter: _selectedValue,
                  ),
                  if (_selectedRange != null &&
                      _selectedValue != PeriodName.all)
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
                        _getIncidents();
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
                child: BlocBuilder<IncidentsCubit, IncidentsState>(
                  builder: (context, state) {
                    if (state is IncidentsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: context.colorExt.textColor,
                        ),
                      );
                    }
                    if (state is IncidentsErrorState) {
                      return Center(
                        child: Text(
                          state.error,
                          style: context.textExt.normal,
                        ),
                      );
                    }
                    if (state is IncidentsLoadedState) {
                      events = state.incidents;
                      events.sort(Utils.sortEventsDescending);

                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                        itemBuilder: (context, index) {
                          final event = events[index];
                          final statusUi =
                              Utils.getStatusUi(context, event.status);
                          var text = '';
                          if (event.date != null) {
                            text = Utils.getBasicDateFormat(date: event.date);
                          } else if (event.startDate != null &&
                              event.endDate != null) {
                            text =
                                '${Utils.getBasicDateFormat(date: event.startDate)} '
                                '- ${Utils.getBasicDateFormat(date: event.endDate)}';
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
                                          incident: event,
                                        );
                                      },
                                    ).then((value) {
                                      if (value == true) {
                                        _getIncidents();
                                        if (!needUpdateCalendar) {
                                          setState(() {
                                            needUpdateCalendar = true;
                                          });
                                        }
                                      }
                                    });
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
                                      context
                                          .read<IncidentsCubit>()
                                          .deleteIncident(incidentId: event.id);
                                      if (!needUpdateCalendar) {
                                        setState(() {
                                          needUpdateCalendar = true;
                                        });
                                      }
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
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
