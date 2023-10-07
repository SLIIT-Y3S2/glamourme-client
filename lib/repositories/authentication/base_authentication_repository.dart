import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_app/models/user_model.dart';

abstract class BaseAuthenticationRepository {
  Stream<auth.User?> get userStream;

  /// This method is used to create a user with email and password
  Future<auth.User?> signup({
    required UserModel user,
    required String password,
  });

  /// This method is used to sign in a user with email and password
  Future<auth.User?> signin({
    required UserModel user,
    required String password,
  });

  /// This method is used to sign out a user
  Future<void> signOut();

  Future<void> addUserIfNotExists({required userId, required UserModel user});
}
