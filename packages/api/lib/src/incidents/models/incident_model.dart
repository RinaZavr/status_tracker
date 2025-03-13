import 'package:json_annotation/json_annotation.dart';

part 'incident_model.g.dart';

@JsonSerializable()
class Incident {
  Incident({
    required this.id,
    required this.userId,
    required this.name,
    required this.surname,
    required this.status,
    this.date,
    required this.isPeriod,
    this.startDate,
    this.endDate,
  });

  factory Incident.fromJson(Map<String, dynamic> json) =>
      _$IncidentFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentToJson(this);

  final int id;
  final int userId;
  final String name;
  final String surname;
  final IncidentStatus status;
  final String? date;
  final bool isPeriod;
  final String? startDate;
  final String? endDate;
}

@JsonEnum(alwaysCreate: true)
enum IncidentStatus {
  @JsonValue('REMOTE')
  remote('Удаленно'),
  @JsonValue('SICK')
  sick('Болезнь'),
  @JsonValue('VACATION')
  vacation('Отпуск'),
  @JsonValue('STUDY')
  study('Учеба'),
  @JsonValue('OTHER')
  other('Другое');

  const IncidentStatus(this.name);

  String toJsonValue() {
    return _$IncidentStatusEnumMap[this] ??
        ''; // Возвращает строковое значение, заданное через @JsonValue
  }

  final String name;
}

@JsonEnum(alwaysCreate: true)
enum PeriodName {
  @JsonValue('DAY')
  day('Текущий день'),

  @JsonValue('WEEK')
  week('Текущая неделя'),

  @JsonValue('MONTH')
  month('Текущий месяц'),

  @JsonValue('YEAR')
  year('Текущий год'),

  @JsonValue('ALL')
  all('Все'),

  @JsonValue('PERIOD')
  period('Произвольный период');

  const PeriodName(this.name);

  String toJsonValue() {
    return _$PeriodNameEnumMap[this] ??
        ''; // Возвращает строковое значение, заданное через @JsonValue
  }

  final String name;
}
