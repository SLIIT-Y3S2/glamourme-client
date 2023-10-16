import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/repositories/salons/base_salon_repository.dart';

class SalonRepository extends BaseSalonRepository {
  @override
  Future<List<SalonModel>> getSalons() async {
    throw UnimplementedError();
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
