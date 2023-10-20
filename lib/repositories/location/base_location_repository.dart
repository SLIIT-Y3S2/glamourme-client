import 'package:flutter_app/models/location_model.dart';

abstract class BaseLocationRepository {
  Future<LocationModel> getLocation();
}
