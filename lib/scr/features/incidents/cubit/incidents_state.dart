part of 'incidents_cubit.dart';

sealed class IncidentsState extends Equatable {
  const IncidentsState();

  @override
  List<Object> get props => [];
}

final class IncidentsInitial extends IncidentsState {}

final class IncidentsLoadingState extends IncidentsState {}

final class IncidentsLoadedState extends IncidentsState {
  const IncidentsLoadedState({required this.incidents});

  final List<Incident> incidents;
}

final class IncidentsErrorState extends IncidentsState {
  const IncidentsErrorState({required this.error});

  final String error;
}
