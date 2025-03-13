// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Incident _$IncidentFromJson(Map<String, dynamic> json) => Incident(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      surname: json['surname'] as String,
      status: $enumDecode(_$IncidentStatusEnumMap, json['status']),
      date: json['date'] as String?,
      isPeriod: json['isPeriod'] as bool,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$IncidentToJson(Incident instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'status': _$IncidentStatusEnumMap[instance.status]!,
      'date': instance.date,
      'isPeriod': instance.isPeriod,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

const _$IncidentStatusEnumMap = {
  IncidentStatus.remote: 'REMOTE',
  IncidentStatus.sick: 'SICK',
  IncidentStatus.vacation: 'VACATION',
  IncidentStatus.study: 'STUDY',
  IncidentStatus.other: 'OTHER',
};

const _$PeriodNameEnumMap = {
  PeriodName.day: 'DAY',
  PeriodName.week: 'WEEK',
  PeriodName.month: 'MONTH',
  PeriodName.year: 'YEAR',
  PeriodName.all: 'ALL',
  PeriodName.period: 'PERIOD',
};
