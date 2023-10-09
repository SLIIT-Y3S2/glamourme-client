import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ServiceModel {
  final String name;
  final String description;
  final String imageUrl;
  final String price;
  final String duration;
  final String? id;

  // Constructor for creating a service from Firestore
  ServiceModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.duration,
    required this.id,
  });

  // Constructor for creating a new service
  ServiceModel.init({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.duration,
  }) : id = uuid.v4();

  // Used to convert the object to a map for storing in Firestore
  toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'duration': duration,
      'id': id,
    };
  }

  //Used to convert the map from Firestore to an object
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        price: json['price'],
        duration: json['duration'],
        id: json['id']);
  }
}
