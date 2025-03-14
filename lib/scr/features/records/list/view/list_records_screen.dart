import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/incident_event_widget.dart';

class ListRecordsScreen extends StatefulWidget {
  const ListRecordsScreen({
    super.key,
    required this.date,
    required this.events,
  });

  final DateTime date;
  final List<CalendarEventData<Incident>> events;

  @override
  State<ListRecordsScreen> createState() => _ListRecordsScreenState();
}

class _ListRecordsScreenState extends State<ListRecordsScreen> {
  String title = '';

  @override
  void initState() {
    title = 'События за '
        '${DateFormat('d MMMM yyyy', 'ru').format(widget.date.withoutTime)} '
        'г.';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: context.textExt.normal,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 5,
            ),
            itemBuilder: (context, index) {
              return IncidentEventWidget(
                event: widget.events[index],
                isSmall: false,
              );
            },
            itemCount: widget.events.length,
          ),
        ),
      ),
    );
  }
}
