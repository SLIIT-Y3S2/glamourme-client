import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/user.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(CreatingUser()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>((event, emit) {});
  }

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUser());
  }
}
