part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentState {
  const AppointmentState();
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  const AppointmentLoaded({required this.appointments});
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError({required this.message});
}

class CreatingAppointmentState extends AppointmentState {}

final class AppointmentCreatedState extends AppointmentState {
  const AppointmentCreatedState();
}

class ValidatingAppointmentState extends AppointmentState {}

class AppointmentValidatedState extends AppointmentState {
  final AppointmentModel appointment;

  const AppointmentValidatedState({required this.appointment});
}
