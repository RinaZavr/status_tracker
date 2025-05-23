import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';

class IncidentEventWidget extends StatelessWidget {
  const IncidentEventWidget({
    super.key,
    required this.event,
    required this.isSmall,
  });

  final CalendarEventData<Incident> event;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final statusUi = Utils.getStatusUi(context, event.event!.status);
    return Container(
      padding: EdgeInsets.all(isSmall ? 3 : 8),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: statusUi['color'],
        borderRadius: BorderRadius.circular(8),
      ),
      child: isSmall
          ? Center(
              child: Text(
                '${event.event!.name[0]}${event.event!.surname[0]}',
                style: context.textExt.normal.copyWith(height: 1),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: [
                Icon(
                  statusUi['icon'],
                  size: isSmall ? 15 : 20,
                ),
                Expanded(
                  child: Text(
                    '${event.event!.name} ${event.event!.surname}',
                    style: context.textExt.normal.copyWith(height: 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}
