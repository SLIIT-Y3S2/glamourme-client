import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';

class CreateUser {
  final AuthenticationRepository _repository;

  const CreateUser(this._repository);

  Future<void> createUser({
    required String email,
    required String password,
    required UserRole userRole,
  }) {
    return _repository.createUser(
      email: email,
      password: password,
      userRole: userRole,
    );
  }
}
