import 'package:uuid/uuid.dart';

enum UserRole {
  salonOwner,
  customer,
}

const Uuid uuid = Uuid();

class User {
  final String userId;
  final String name;
  final String email;
  final UserRole userRole;

  User({
    required this.name,
    required this.email,
    required this.userRole,
  }) : userId = uuid.v4();
}
