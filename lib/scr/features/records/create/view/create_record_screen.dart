import 'package:api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/features/records/my/view/widgets/date_picker_widget.dart';
import 'package:status_tracker/scr/features/records/my/view/widgets/incident_status_widget.dart';

class CreateRecordScreen extends StatefulWidget {
  const CreateRecordScreen({super.key, this.dates, this.status});

  final List<DateTime>? dates;
  final IncidentStatus? status;

  @override
  State<CreateRecordScreen> createState() => _CreateRecordScreenState();
}

class _CreateRecordScreenState extends State<CreateRecordScreen> {
  IncidentStatus? _selectedStatus;

  bool isPeriod = false;

  @override
  void initState() {
    _selectedStatus = widget.status;
    if (widget.dates != null && widget.dates!.first != widget.dates!.last) {
      isPeriod = true;
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
            widget.dates == null ? 'Новая запись' : 'Редактирование',
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
                  onChangedRange: (range) {},
                  selectedRange: widget.dates == null
                      ? null
                      : DateTimeRange(
                          start: widget.dates!.first,
                          end: widget.dates!.last,
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
                            isPeriod = value ?? !isPeriod;
                          });
                        },
                      ),
                      Text(
                        'Период',
                        style: context.textExt.normal,
                      ),
                      const Spacer(),
                      CustomButton(
                        onPressed: () {
                          context.pop();
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
