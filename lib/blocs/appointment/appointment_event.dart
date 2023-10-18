part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentEvent {
  const AppointmentEvent();
}

class CreateAppointmentEvent extends AppointmentEvent {
  final AppointmentModel appointment;

  const CreateAppointmentEvent({required this.appointment});
}

class ValidateAppointmentEvent extends AppointmentEvent {
  final AppointmentModel appointment;

  const ValidateAppointmentEvent({required this.appointment});
}

class GetAppointmentsEvent extends AppointmentEvent {
  final String userId;

  const GetAppointmentsEvent({required this.userId});
}
