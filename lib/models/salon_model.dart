import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Affordability {
  affordable,
  pricey,
}

enum SalonType {
  gents,
  ladies,
  unisex,
}

class SalonModel {
  final String? salonId;
  final String salonName;
  final String location;
  final String imageUrl;
  final String description;
  final String contactNumber;
  final double rating;
  final Affordability affordability;
  final List<String> services;
  final double latitude;
  final double longitude;
  final SalonType? salonType;

  const SalonModel({
    required this.salonId,
    required this.salonName,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.contactNumber,
    required this.rating,
    required this.affordability,
    required this.services,
    required this.latitude,
    required this.longitude,
    required this.salonType,
  });

  SalonModel.init({
    required this.salonName,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.contactNumber,
    required this.rating,
    required this.affordability,
    required this.services,
    required this.latitude,
    required this.longitude,
    required this.salonType,
  }) : salonId = uuid.v4();

  toJson() {
    return {
      'salonId': salonId,
      'salonName': salonName,
      'location': location,
      'imageUrl': imageUrl,
      'description': description,
      'contactNumber': contactNumber,
      'rating': rating,
      'affordability': affordability == Affordability.affordable
          ? 'affordable'
          : affordability == Affordability.pricey
              ? 'pricey'
              : 'luxurious',
      'services': services,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      salonId: json['salonId'],
      salonName: json['salonName'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      contactNumber: json['contactNumber'],
      rating: json['rating'],
      affordability: json['affordability'] == 'affordable'
          ? Affordability.affordable
          : Affordability.pricey,
      services: json['services'].cast<String>(),
      latitude: json['latitude'],
      longitude: json['longitude'],
      salonType: json['salonType'] == 'gents'
          ? SalonType.gents
          : json['ladies']
              ? SalonType.ladies
              : SalonType.unisex,
    );
  }
}
