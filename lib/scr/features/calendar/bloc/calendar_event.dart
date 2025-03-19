part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

final class GetMonthEvents extends CalendarEvent {
  const GetMonthEvents({
    required this.date,
  });

  final DateTime date;
}
