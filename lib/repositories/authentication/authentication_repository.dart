import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_app/exceptions/auth_exceptions.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/repositories/authentication/base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _db;

  @override
  Stream<auth.User?> get userStream => _firebaseAuth.userChanges();
  Stream<auth.User?> get authState => _firebaseAuth.authStateChanges();

  //User id of the current user
  @override
  String get userId => _firebaseAuth.currentUser?.uid ?? '';

  // Current user.
  @override
  auth.User? get currentUser => _firebaseAuth.currentUser;

  AuthenticationRepository(
      {auth.FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _db = firestore ?? FirebaseFirestore.instance;

  /// Create a user with email and password
  @override
  Future<auth.User?> signup(
      {required UserModel user, required password}) async {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser;
    }
    //Firebase Auth API to create user
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      await addUserIfNotExists(
        userId: userId,
        user: user,
      );

      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      developer.log('message: ${e.message}', stackTrace: e.stackTrace);
      if (e.code == 'weak-password') {
        throw WeakPasswordException(
          code: 'weak-password',
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistException(
          code: 'weak-password',
          message: 'The account already exists for that email.',
        );
      }
      return null;
    } catch (e) {
      developer.log(e.toString());
      throw Exception(e);
    }
  }

  /// Used to sign in a user with email and password
  @override
  Future<auth.User?> signin({
    required UserModel user,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      await addUserIfNotExists(userId: userId, user: user);
      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      developer.log(e.toString());
      return null;
    }
  }

  /// Used to sign out a user
  @override
  Future<void> signOut() async {
    developer.log("message: 'signing out'");
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addUserIfNotExists({
    required userId,
    required UserModel user,
  }) async {
    final usersCollection = _db.collection('users');
    final doc = await usersCollection.doc(userId).get();
    if (!doc.exists) {
      developer.log('user does not exist, adding user to firestore');
      await usersCollection.doc(userId).set({
        'name': user.name,
        'role': user.userRole == UserRole.customer ? 'customer' : 'salonOwner',
        'email': user.email
      });
    }
  }
}
