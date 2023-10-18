import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/models/service_model.dart';
import 'package:flutter_app/repositories/salons/base_salon_repository.dart';

class SalonRepository extends BaseSalonRepository {
  @override
  Future<List<SalonModel>> getSalons() async {
    List<SalonModel> salons = [];
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    late CollectionReference _salonCollection;

    _salonCollection = _db.collection('salons');

    try {
      final salonSnapshot = await _salonCollection.get();

      if (salonSnapshot.docs.isNotEmpty) {
        for (var doc in salonSnapshot.docs) {
          SalonModel salon = SalonModel.fromJson(doc);
          salons.add(salon);
        }
      }

      return salons;
    } on StateError catch (e) {
      throw Exception(e.stackTrace);
    } on TypeError catch (e) {
      developer.log(e.runtimeType.toString(), name: 'SalonRepository');
      throw Exception(e.stackTrace);
    }
  }

  @override
  Future<SalonModel> getSalon(String salonId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<SalonModel>> getRecommendedSalons() async {
    throw UnimplementedError();
  }

  @override
  Future<List<SalonModel>> getNearbySalons() async {
    throw UnimplementedError();
  }

  @override
  Future<List<SalonModel>> getSalonsByType(SalonType salonType) async {
    throw UnimplementedError();
  }

  @override
  Future<List<SalonModel>> getSalonsByService(String serviceId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<SalonModel>> getSalonsByLocation(String location) async {
    throw UnimplementedError();
  }

  @override
  Future<List<SalonModel>> getSalonsByRating(double rating) async {
    throw UnimplementedError();
  }

  @override
  Future<List<SalonModel>> getSalonsByAffordability(
      Affordability affordability) async {
    throw UnimplementedError();
  }
}
