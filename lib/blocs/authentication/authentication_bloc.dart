import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/exceptions/auth_exceptions.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';
import 'dart:developer' as developer;
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._authenticationRepository)
      : super(const AuthenticationInitialState()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetCurrentUserEvent>(_getUserHandler);
    on<SignOutEvent>(
      _signOutHandler,
    );
  }

  final AuthenticationRepository _authenticationRepository;

  // Event handler to log in with email and password
  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUserState());
    developer.log('email: ${event.email}');
    try {
      final UserModel user = UserModel(
        name: event.name,
        email: event.email,
        userRole: event.userRole,
      );
      await _authenticationRepository.signup(
        user: user,
        password: event.password,
      );
      UserModel user1 = UserModel(
          email: event.email, userRole: event.userRole, name: event.name);
      emit(UserCreatedState(user1));
    } on EmailAlreadyExistException catch (e) {
      emit(SigninErrorState(e.message));
    } on WeakPasswordException catch (e) {
      emit(SigninErrorState(e.message));
    } catch (e) {
      emit(SigninErrorState(e.toString()));
    }
  }

  // Event handler to get the current user
  Future<void> _getUserHandler(
      GetCurrentUserEvent event, Emitter<AuthenticationState> emit) async {
    final currentUser = _authenticationRepository.currentUser;
    UserModel? user;
    if (currentUser != null) {
      user = UserModel(
        name: currentUser.displayName ?? "",
        email: currentUser.email ?? "",
        userRole: UserRole.customer,
      );
    }
    developer.log('email: ${user?.email}');
    emit(CurrentUserState(user));
  }

  // Event handler to sign out
  Future<void> _signOutHandler(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    await _authenticationRepository.signOut();
    emit(const AuthenticationInitialState());
  }
}
