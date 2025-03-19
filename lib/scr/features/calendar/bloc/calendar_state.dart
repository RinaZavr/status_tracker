part of 'calendar_bloc.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

final class CalendarInitialState extends CalendarState {}

final class CalendarLoadingState extends CalendarState {}

final class CalendarLoadedState extends CalendarState {
  const CalendarLoadedState({required this.events, required this.currentDate});

  final List<CalendarEventData<Incident>> events;
  final DateTime currentDate;
}

final class CalendarErrorState extends CalendarState {
  const CalendarErrorState({required this.error});

  final String error;
}
