import 'package:flutter_app/models/salon_model.dart';

abstract class BaseSalonRepository {
  Future<List<SalonModel>> getSalons();

  Future<SalonModel> getSalon(String salonId);

  Future<List<SalonModel>> getRecommendedSalons();

  Future<List<SalonModel>> getNearbySalons();

  Future<List<SalonModel>> getSalonsByType(GenderType genderType);

  Future<List<SalonModel>> getSalonsByService(String serviceId);

  Future<List<SalonModel>> getSalonsByLocation(String location);

  Future<List<SalonModel>> getSalonsByRating(double rating);

  Future<List<SalonModel>> getSalonsByAffordability(
    Affordability affordability,
  );
}
