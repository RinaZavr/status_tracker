import 'dart:developer';

import 'package:api/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'incidents_state.dart';

class IncidentsCubit extends Cubit<IncidentsState> {
  IncidentsCubit() : super(IncidentsInitial());

  Future<void> getIncidents({
    required PeriodName period,
    DateTime? startDate,
    DateTime? endDate,
    required List<IncidentStatus> statuses,
  }) async {
    try {
      emit(IncidentsLoadingState());

      final incidents = await IncidentsService().getUserIncidents(
        userId: DioClient().user?.id,
        period: period,
        startDate: startDate,
        endDate: endDate,
        statuses: statuses,
      );

      emit(IncidentsLoadedState(incidents: incidents));
    } catch (e) {
      emit(
        const IncidentsErrorState(
          error: 'Не удалось загрузить инциденты',
        ),
      );
    }
  }

  Future<void> createIncident({required Incident incident}) async {
    try {
      await IncidentsService().createIncident(
        incident: incident,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateIncident({
    required Incident incident,
  }) async {
    try {
      await IncidentsService().updateIncident(
        incident: incident,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteIncident({
    required int incidentId,
  }) async {
    try {
      await IncidentsService().deleteIncident(
        incidentId: incidentId,
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
