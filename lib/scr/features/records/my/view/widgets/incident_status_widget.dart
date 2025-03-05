import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/cell_calendar_widget.dart';

class IncidentStatusWidget extends StatelessWidget {
  const IncidentStatusWidget({
    super.key,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  final IncidentStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusUi = Utils.getStatusUi(context, status);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isSelected ? statusUi['color'] : context.colorExt.backgroundColor,
          border: isSelected
              ? null
              : Border.all(color: context.colorExt.lightBorderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Icon(
              statusUi['icon'],
              size: 20,
            ),
            Text(
              status.name,
              style: context.textExt.normal,
            ),
          ],
        ),
      ),
    );
  }
}
