import 'dart:developer';

import 'package:api/api_client.dart';
import 'package:api/src/secure_storage.dart';

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

    // if (userId != null) {
    //   data['userId'] = userId;
    // }

    // if (startDate != null) {
    //   data['startDate'] = startDate;
    // }

    // if (endDate != null) {
    //   data['endDate'] = endDate;
    // }

    // if (statuses.isNotEmpty) {
    //   data['statuses'] =
    //       statuses.map((status) => status.toJsonValue()).toList();
    // }

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

  Future<Map<String, dynamic>> createIncident({
    required Incident incident,
  }) async {
    final response = await _dioClient.dio.post(
      '/incidents/create',
      data: incident.toJson(),
    );

    final result = <String, dynamic>{};

    if (response.statusCode == 200) {
      result['massage'] = response.data['message'];
      result['incident'] = Incident.fromJson(response.data['incident']);
    }

    return result;
  }

  Future<Map<String, dynamic>> updateIncident({
    required Incident incident,
  }) async {
    log((await SecureStorage.getToken()).toString());
    log(incident.toJson().toString());

    final response = await _dioClient.dio.put(
      '/incidents/update',
      data: incident.toJson(),
    );

    final result = <String, dynamic>{};

    if (response.statusCode == 200) {
      result['massage'] = response.data['message'];
      result['incident'] = Incident.fromJson(response.data['incident']);
    }

    return result;
  }

  Future<Map<String, dynamic>> deleteIncident({
    required int incidentId,
  }) async {
    final response = await _dioClient.dio.delete(
      '/incidents/delete',
      data: {
        'id': incidentId,
      },
    );

    final result = <String, dynamic>{};

    if (response.statusCode == 200) {
      result['massage'] = response.data['message'];
      result['id'] = response.data['id'];
    }

    return result;
  }
}
