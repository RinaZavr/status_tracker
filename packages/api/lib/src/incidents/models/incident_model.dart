import 'dart:convert';

class Incident {
  Incident({
    required this.id,
    required this.userId,
    required this.name,
    required this.surname,
    required this.status,
    required this.date,
    required this.isPeriod,
    required this.startDate,
    required this.endDate,
  });

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      status: IncidentStatus.values
          .where((element) => element.toShortString() == map['status'])
          .first,
      date: map['date'] ?? '',
      isPeriod: map['isPeriod'] ?? false,
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
    );
  }

  factory Incident.fromJson(String source) =>
      Incident.fromMap(json.decode(source));
  final int id;
  final int userId;
  final String name;
  final String surname;
  final IncidentStatus status;
  final String date;
  final bool isPeriod;
  final String startDate;
  final String endDate;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'surname': surname,
      'status': status.toShortString(),
      'date': date,
      'isPeriod': isPeriod,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  String toJson() => json.encode(toMap());
}

enum IncidentStatus {
  remote('Удаленно'),
  sick('Болезнь'),
  vacation('Отпуск'),
  study('Учеба'),
  other('Другое');

  const IncidentStatus(this.name);
  final String name;

  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}
