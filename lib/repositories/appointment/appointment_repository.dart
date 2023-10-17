import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_app/repositories/appointment/base_appointment_repository.dart';

class AppointmentRepository extends BaseAppointmentRepository {
  @override
  Future<AppointmentModel> createAppointment(
      AppointmentModel appointment) async {
    developer.log(appointment.toJson().toString(),
        name: 'AppointmentRepository');
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference appointmentCollection =
        db.collection('appointments');
    await appointmentCollection.doc(appointment.id).set({
      ...appointment.toJson(),
      'client': db.collection('users').doc(appointment.customerId),
      'salon': db.collection('salons').doc(appointment.salonId),
    }).onError((error, stackTrace) {
      developer.log(
        error.toString(),
        error: error,
        stackTrace: stackTrace,
        name: 'AppointmentRepository',
      );
      throw Exception(error);
    });

    return appointment;
  }

  @override
  Future<void> deleteAppointment(int id) {
    // TODO: implement deleteAppointment
    throw UnimplementedError();
  }

  @override
  Future<AppointmentModel> getAppointment(int id) {
    // TODO: implement getAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<AppointmentModel>> getAppointments() {
    // TODO: implement getAppointments
    throw UnimplementedError();
  }

  @override
  Future<AppointmentModel> updateAppointment(AppointmentModel appointment) {
    // TODO: implement updateAppointment
    throw UnimplementedError();
  }

  @override
  Future<bool> validateAppointment(AppointmentModel appointment) {
    // TODO: implement validateAppointment
    throw UnimplementedError();
  }
}
