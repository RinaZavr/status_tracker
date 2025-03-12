import 'dart:convert';

class User {
  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.login,
    required this.email,
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      login: map['login'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  final int id;
  final String name;
  final String surname;
  final String login;
  final String email;
  final String token;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'login': login,
      'email': email,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());
}
