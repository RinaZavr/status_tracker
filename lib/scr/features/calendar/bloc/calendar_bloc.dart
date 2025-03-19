import 'package:api/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:equatable/equatable.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitialState()) {
    on<GetMonthEvents>(_onGetMonthEvents);
  }

  Future<void> _onGetMonthEvents(
    GetMonthEvents event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarLoadingState());

    try {
      final events = await IncidentsService().getMonthIncidents(
        month: event.date.month,
        year: event.date.year,
      );
      final eventList = events.map((incident) {
        return CalendarEventData<Incident>(
          title: '${incident.name} ${incident.surname}',
          date: DateTime.parse(incident.date ?? incident.startDate!),
          endDate: incident.endDate == null
              ? null
              : DateTime.parse(incident.endDate!),
          event: incident,
        );
      }).toList();

      emit(CalendarLoadedState(events: eventList, currentDate: event.date));
    } catch (_) {
      emit(const CalendarErrorState(error: 'Не удалось загрузить события'));
    }
  }
}
