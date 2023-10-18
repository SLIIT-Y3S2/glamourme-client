import 'package:flutter_app/models/appointment_model.dart';

abstract class BaseAppointmentRepository {
  Future<List<AppointmentModel>> getAppointments(String userId);
  Future<AppointmentModel> getAppointment(int id);
  Future<AppointmentModel> createAppointment(AppointmentModel appointment);
  Future<AppointmentModel> updateAppointment(AppointmentModel appointment);
  Future<void> deleteAppointment(int id);
  Future<bool> validateAppointment(AppointmentModel appointment);
}
