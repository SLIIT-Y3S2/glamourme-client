part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

// Create an event to log in with email and password
class CreateUserEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final UserRole userRole;

  const CreateUserEvent({
    required this.email,
    required this.password,
    required this.userRole,
  });
}

class GetUserEvent extends AuthenticationEvent {
  const GetUserEvent();
}
