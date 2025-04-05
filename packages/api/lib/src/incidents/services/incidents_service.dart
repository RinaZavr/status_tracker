import 'package:api/api_client.dart';

class IncidentsService {
  final DioClient _dioClient = DioClient();

  Future<List<Incident>> getMonthIncidents({
    required int month,
    required int year,
  }) async {
    final response = await _dioClient.dio.get(
      '/incidents/all',
      queryParameters: {
        'month': month - 1,
        'year': year,
      },
    );

    final incidents = <Incident>[];

    if (response.statusCode == 200) {
      for (final incident in response.data) {
        incidents.add(Incident.fromJson(incident));
      }
    }

    return incidents;
  }

  Future<List<Incident>> getUserIncidents({
    required int? userId,
    required PeriodName period,
    DateTime? startDate,
    DateTime? endDate,
    required List<IncidentStatus> statuses,
  }) async {
    final data = <String, dynamic>{
      'userId': userId,
      'periodName': period.toJsonValue(),
      'statuses': statuses.map((status) => status.toJsonValue()).toList(),
      'startDate': startDate?.toUtc().toIso8601String(),
      'endDate': endDate?.toUtc().toIso8601String(),
    };

    final response = await _dioClient.dio.post(
      '/incidents/get',
      data: data,
    );

    final incidents = <Incident>[];

    if (response.statusCode == 200) {
      for (final incident in response.data) {
        incidents.add(Incident.fromJson(incident));
      }
    }

    return incidents;
  }

  Future<Incident?> createIncident({
    required Incident incident,
  }) async {
    final response = await _dioClient.dio.post(
      '/incidents/create',
      data: incident.toJson(),
    );

    if (response.statusCode == 200) {
      return Incident.fromJson(response.data['incident']);
    }

    return null;
  }

  Future<Incident?> updateIncident({
    required Incident incident,
  }) async {
    final response = await _dioClient.dio.put(
      '/incidents/update',
      data: incident.toJson(),
    );

    if (response.statusCode == 200) {
      return Incident.fromJson(response.data['incident']);
    }

    return null;
  }

  Future<String?> deleteIncident({
    required int incidentId,
  }) async {
    final response = await _dioClient.dio.delete(
      '/incidents/delete',
      data: {
        'id': incidentId,
      },
    );

    if (response.statusCode == 200) {
      return response.data['id'];
    }

    return null;
  }
}
