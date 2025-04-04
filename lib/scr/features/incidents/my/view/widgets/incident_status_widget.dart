import 'package:api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';

class IncidentStatusWidget extends StatelessWidget {
  const IncidentStatusWidget({
    super.key,
    required this.status,
    this.text,
    required this.isSelected,
    required this.onTap,
  });

  final IncidentStatus status;
  final String? text;
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
              text ?? status.name,
              style: context.textExt.normal,
            ),
          ],
        ),
      ),
    );
  }
}
