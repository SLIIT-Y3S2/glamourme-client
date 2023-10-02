import 'package:flutter_app/models/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<void> createUser({
    required String email,
    required String password,
    required UserRole userRole,
  });

  Future<void> logInWithGoogle();

  Future<void> logOut();

  Future<bool> isSignedIn();

  Future<String> getUser();
}
