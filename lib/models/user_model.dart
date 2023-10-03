import 'package:uuid/uuid.dart';

enum UserRole {
  salonOwner,
  customer,
}

const Uuid uuid = Uuid();

class UserModel {
  final String userId;
  final String name;
  final String email;
  final UserRole userRole;

  UserModel({
    required this.name,
    required this.email,
    required this.userRole,
  }) : userId = uuid.v4();
}
