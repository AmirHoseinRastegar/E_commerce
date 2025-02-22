part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final Timestamp createdAt;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.createdAt,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}
class LogOutEvent extends AuthEvent{}
