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
  });

  factory AppointmentModel.fromJson(QueryDocumentSnapshot doc) {
    return AppointmentModel(
      id: doc['id'],
      title: doc['title'],
      description: doc['description'],
      startTime: doc['startTime'],
      endTime: doc['endTime'],
      status: doc['status'],
      salonId: doc['salonId'],
      customerId: doc['customerId'],
      serviceId: doc['serviceId'],
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
