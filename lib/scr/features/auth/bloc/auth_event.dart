part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  const AuthLoginEvent({
    required this.login,
    required this.password,
  });

  final String login;
  final String password;
}

class AuthRegisterEvent extends AuthEvent {
  const AuthRegisterEvent({
    required this.name,
    required this.surname,
    required this.login,
    required this.email,
    required this.password,
    required this.secretKey,
  });

  final String name;
  final String surname;
  final String login;
  final String email;
  final String password;
  final String secretKey;
}

class AuthGetMeEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
