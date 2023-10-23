import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class AppointmentModel {
  final String id;
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final String status;
  final String salonId;
  final String customerId;
  final String serviceId;
  final String? salonName;

  AppointmentModel({
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.salonId,
    required this.customerId,
    required this.serviceId,
    required this.salonName,
  });

  factory AppointmentModel.fromJson(QueryDocumentSnapshot doc) {
    late String salonName = '';
    final salonId = doc.reference.collection('salon').id;

    final customerId = doc.reference.collection('client').id;

    // developer.log(salonDoc['salonName'], name: 'AppointmentModel');

    return AppointmentModel(
        id: doc['id'],
        title: doc['title'],
        description: doc['description'],
        startTime: doc['startTime'],
        endTime: doc['endTime'],
        status: doc['status'],
        salonId: salonId, //doc.['salon']
        customerId: customerId, //doc['customerId'],
        serviceId: doc['service'],
        salonName: '' //salonDoc['salonName'],
        );
  }

  AppointmentModel.init({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.salonId,
    required this.customerId,
    required this.serviceId,
    this.salonName,
  }) : id = uuid.v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'salon': salonId,
      'client': customerId,
      'service': serviceId,
    };
  }
}
