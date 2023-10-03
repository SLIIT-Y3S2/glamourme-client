import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/repositories/authentication/base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Stream<auth.User?> get userStream => _firebaseAuth.userChanges();
  Stream<auth.User?> get authState => _firebaseAuth.authStateChanges();

  String get userId => _firebaseAuth.currentUser?.uid ?? '';

  auth.User? get currentUser => _firebaseAuth.currentUser;

  AuthenticationRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  /// This method is used to create a user with email and password
  @override
  Future<auth.User?> signup({
    required String name,
    required String email,
    required String password,
    required UserRole userRole,
  }) async {
    //Firebase Auth API to create user
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUserIfNotExists(userId);

      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      developer.log('message: ${e.message}', stackTrace: e.stackTrace);
      if (e.code == 'weak-password') {
        developer.log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        developer.log('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      developer.log(e.toString());
      return null;
    }
  }

  /// This method is used to sign in a user with email and password
  @override
  Future<auth.User?> signin({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      await addUserIfNotExists(userId);
      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      developer.log(e.toString());
      return null;
    }
  }

  /// This method is used to sign out a user
  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addUserIfNotExists(userId) async {
    var doc = await _usersCollection.doc(userId).get();
    if (!doc.exists) {
      developer.log('user does not exist, adding user to firestore');
      await _usersCollection.doc(userId).set({
        'role': UserRole.customer.toString(),
      });
    }
  }
}
