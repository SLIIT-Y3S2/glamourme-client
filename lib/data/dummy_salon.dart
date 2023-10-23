import 'package:flutter/material.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/models/service_model.dart';

final salonList = [
  SalonModel.init(
    salonName: 'Salon Sapphire',
    location: 'Malabe',
    imageUrl:
        'https://images.pexels.com/photos/897262/pexels-photo-897262.jpeg?auto=compress&cs=tinysrgb&w=750&h=750&dpr=1',
    description: 'This is a description',
    contactNumber: '0112345678',
    rating: 4.5,
    affordability: Affordability.pricey,
    services: serviceData,
    latitude: 6.9147,
    longitude: 79.9733,
    salonType: GenderType.unisex,
    openingHours: [
      OpeningHoursDataModel(
        day: 'Monday',
        openingTime: TimeOfDay(hour: 9, minute: 0),
        closingTime: TimeOfDay(hour: 18, minute: 0),
        isOpen: true,
      ),
      // Add more opening hours for other days
    ],
    website: 'https://www.google.com',
    categories: [],
    salonOwnerId: '',
  ),
  SalonModel.init(
    salonName: 'Salon Ruby',
    location: 'Colombo',
    imageUrl:
        'https://images.pexels.com/photos/3993463/pexels-photo-3993463.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    description: 'Another description',
    contactNumber: '0119876543',
    rating: 4.2,
    affordability: Affordability.affordable,
    services: serviceData,
    latitude: 6.9273,
    longitude: 79.8524,
    salonType: GenderType.ladies,
    openingHours: [
      // Define opening hours for Salon Ruby
    ],
    website: '',
    salonOwnerId: '',
    categories: [],
  ),
  // Add more dummy salons as needed
];

final serviceData = [
  ServiceModel.init(
    name: 'Hair Cut',
    imageUrl:
        'https://images.pexels.com/photos/987654/pexels-photo-987654.jpeg?auto=compress&cs=tinysrgb&w=750&h=750&dpr=1',
    description: 'Hair Cut',
    price: 500.00,
    duration: '1 Hour',
    serviceGender: 'gents',
  ),
  ServiceModel.init(
    name: 'Manicure',
    imageUrl:
        'https://images.pexels.com/photos/3993463/pexels-photo-3993463.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    description: 'Manicure Service',
    price: 250.00,
    duration: '45 Minutes',
    serviceGender: 'ladies',
  ),
  // Add more dummy services as needed
];
