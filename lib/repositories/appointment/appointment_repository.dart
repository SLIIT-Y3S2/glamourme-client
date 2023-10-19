import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_app/repositories/appointment/base_appointment_repository.dart';

class AppointmentRepository extends BaseAppointmentRepository {
  // @override
  // Future<AppointmentModel> createAppointment(
  //     AppointmentModel appointment) async {
  //   final FirebaseFirestore db = FirebaseFirestore.instance;
  //   final CollectionReference appointmentCollection =
  //       db.collection('appointments');
  //   await appointmentCollection.doc(appointment.id).set({
  //     ...appointment.toJson(),
  //     'client': db.collection('users').doc(appointment.customerId),
  //     'salon': db.collection('salons').doc(appointment.salonId),
  //   }).onError((error, stackTrace) {
  //     developer.log(
  //       error.toString(),
  //       error: error,
  //       stackTrace: stackTrace,
  //       name: 'AppointmentRepository',
  //     );
  //     throw Exception(error);
  //   });

  //   return appointment;
  // }

  @override
  Future<AppointmentModel> createAppointment(
      AppointmentModel appointment) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference appointmentCollection =
        db.collection('appointments');
    // developer.log(appointment.toJson().toString(),
    //     name: 'AppointmentRepository');
    developer.log('${appointment.startTime}', name: 'AppointmentRepository');

    var reference = db.collection("salons").doc(appointment.salonId);

    // Check if there are any overlapping appointments.
    final overlappingSalonAndStarTimeQuerySnapshot = await appointmentCollection
        .where('salon', isEqualTo: reference)
        .where('startTime', isLessThan: appointment.endTime.toDate())
        .get()
        .catchError((error, stackTrace) {
      developer.log(
        error.toString(),
        error: error,
        stackTrace: stackTrace,
        name: 'AppointmentRepository',
      );
      throw Exception(error);
    });
    var overLappingEndtime = overlappingSalonAndStarTimeQuerySnapshot.docs
        .where((element) => element
            .get('endTime')
            .toDate()
            .isAfter(appointment.startTime.toDate()));

    for (var element in overLappingEndtime) {
      developer.log(element.get('endTime').toDate().toString(),
          name: 'AppointmentRepository');
    }

    developer.log('Line 57', name: 'AppointmentRepository');
    developer.log('Line 61', name: 'AppointmentRepository');

    if (overLappingEndtime.isEmpty) {
      // No overlapping appointments found, add the new appointment.
      await appointmentCollection.doc(appointment.id).set({
        ...appointment.toJson(),
        'client': db.collection('users').doc(appointment.customerId),
        'salon': db.collection('salons').doc(appointment.salonId),
      }).onError((error, stackTrace) {
        // Handle the error.
        developer.log(
          error.toString(),
          error: error,
          stackTrace: stackTrace,
          name: 'AppointmentRepository',
        );
      });
    } else {
      throw Exception('Appointment overlaps with existing appointments');
    }

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
