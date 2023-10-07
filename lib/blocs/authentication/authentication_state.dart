part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}

class CreatingUserState extends AuthenticationState {
  const CreatingUserState();
}

class SigninErrorState extends AuthenticationState {
  final String errorMessage;
  const SigninErrorState(this.errorMessage);
}

class GettingUser extends AuthenticationState {
  const GettingUser();
}

class UserCreatedState extends AuthenticationState {
  final UserModel user;

  const UserCreatedState(this.user);
}

class UserRetrieved extends AuthenticationState {
  final UserModel user;

  const UserRetrieved(this.user);
}
