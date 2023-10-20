import 'package:flutter_app/models/location_model.dart';
import 'package:geolocator/geolocator.dart';

abstract class BaseLocationRepository {
  Future<LocationModel> getLocation();
}
