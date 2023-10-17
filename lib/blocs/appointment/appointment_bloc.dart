import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_app/repositories/appointment/appointment_repository.dart';
import 'package:meta/meta.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  AppointmentBloc() : super(AppointmentInitial()) {
    on<CreateAppointmentEvent>(_onCreateAppointment);
    on<ValidateAppointmentEvent>(_onValidateAppointment);
  }

  void _onCreateAppointment(
    CreateAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(CreatingAppointmentState());
    await _appointmentRepository.createAppointment(event.appointment).then(
      (appointment) {
        emit(const AppointmentCreatedState());
      },
    ).catchError(
      (error) {
        emit(AppointmentError(message: error.toString()));
      },
    );
  }

  void _onValidateAppointment(
    ValidateAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) {
    emit(ValidatingAppointmentState());
    _appointmentRepository.createAppointment(event.appointment).then(
      (appointment) {
        emit(AppointmentValidatedState(appointment: appointment));
      },
    ).catchError(
      (error) {
        emit(AppointmentError(message: error.toString()));
      },
    );
  }
}
