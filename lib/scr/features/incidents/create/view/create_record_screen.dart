import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/features/incidents/cubit/incidents_cubit.dart';
import 'package:status_tracker/scr/features/incidents/my/view/widgets/date_picker_widget.dart';
import 'package:status_tracker/scr/features/incidents/my/view/widgets/incident_status_widget.dart';

class CreateRecordScreen extends StatefulWidget {
  const CreateRecordScreen({super.key, this.incident});

  final Incident? incident;

  @override
  State<CreateRecordScreen> createState() => _CreateRecordScreenState();
}

class _CreateRecordScreenState extends State<CreateRecordScreen> {
  IncidentStatus _selectedStatus = IncidentStatus.remote;

  List<DateTime> dates = [DateTime.now()];

  bool isPeriod = false;

  @override
  void initState() {
    _selectedStatus = widget.incident?.status ?? IncidentStatus.remote;

    isPeriod = widget.incident?.isPeriod ?? false;

    if (widget.incident?.startDate != null &&
        widget.incident?.endDate != null) {
      dates = [
        DateTime.parse(widget.incident!.startDate!),
        DateTime.parse(widget.incident!.endDate!),
      ];
    } else if (widget.incident?.date != null) {
      dates = [
        DateTime.parse(widget.incident!.date!),
      ];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            widget.incident == null ? 'Новая запись' : 'Редактирование',
            style: context.textExt.title,
          ),
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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: DatePickerWidget(
                  onChangedRange: (range) {
                    setState(() {
                      if (!isPeriod) {
                        dates = [range.start.withoutTime];
                      } else {
                        dates = [
                          range.start.withoutTime,
                          range.end.withoutTime,
                        ];
                      }
                    });
                  },
                  selectedRange: dates.length != 2
                      ? DateTimeRange(
                          start: dates.first,
                          end: dates.first,
                        )
                      : DateTimeRange(
                          start: dates.first,
                          end: dates.last,
                        ),
                  isSingle: !isPeriod,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Тип события',
                    style: context.textExt.titleMiddle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: IncidentStatus.values.map((status) {
                    final isSelected = status == _selectedStatus;
                    return IncidentStatusWidget(
                      status: status,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedStatus = status;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Checkbox(
                        fillColor: WidgetStatePropertyAll(
                          isPeriod
                              ? context.colorExt.buttonColor
                              : Colors.transparent,
                        ),
                        value: isPeriod,
                        onChanged: (value) {
                          setState(() {
                            isPeriod = !isPeriod;
                          });
                        },
                      ),
                      Text(
                        'Период',
                        style: context.textExt.normal,
                      ),
                      const Spacer(),
                      CustomButton(
                        onPressed: () async {
                          final startDate = isPeriod
                              ? dates.first.toUtc().toIso8601String()
                              : null;
                          final endDate = isPeriod
                              ? dates.last.toUtc().toIso8601String()
                              : null;
                          final date = isPeriod
                              ? null
                              : dates.first.toUtc().toIso8601String();
                          if (widget.incident != null) {
                            await context.read<IncidentsCubit>().updateIncident(
                                  incident: Incident(
                                    id: widget.incident!.id,
                                    userId: widget.incident!.userId,
                                    name: widget.incident!.name,
                                    surname: widget.incident!.surname,
                                    isPeriod: isPeriod,
                                    status: _selectedStatus,
                                    startDate: startDate,
                                    endDate: endDate,
                                    date: date,
                                  ),
                                );
                          } else {
                            await context.read<IncidentsCubit>().createIncident(
                                  incident: Incident(
                                    id: 0,
                                    userId: DioClient().user?.id ?? 0,
                                    name: DioClient().user?.name ?? '',
                                    surname: DioClient().user?.surname ?? '',
                                    isPeriod: isPeriod,
                                    status: _selectedStatus,
                                    startDate: startDate,
                                    endDate: endDate,
                                    date: date,
                                  ),
                                );
                          }
                          await Future.delayed(
                            const Duration(seconds: 1),
                          );
                          context.pop(true);
                        },
                        backgroundColor: context.colorExt.buttonColor,
                        child: Text(
                          'Подтвердить',
                          style: context.textExt.normal
                              .copyWith(color: AppColors.raisinblacksecond),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
