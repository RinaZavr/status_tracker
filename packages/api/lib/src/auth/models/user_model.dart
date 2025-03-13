import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.login,
    required this.email,
    // required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String surname;
  final String login;
  final String email;
  // final String token;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
