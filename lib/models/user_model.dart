enum UserRole {
  salonOwner,
  customer,
}

class UserModel {
  final String userId;
  final String name;
  final String email;
  final UserRole userRole;
  final List<String> favoriteSalons = [];

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.userRole,
  });

  // Function to convert the user model to a json object
  toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'userRole': userRole == UserRole.customer ? 'customer' : 'salonOwner',
        'favoriteSalons': favoriteSalons,
      };

  // Function to convert the json object to a user model
  factory UserModel.fromJson(Map<String, String> json) {
    return UserModel(
      userId: json['userId']!,
      name: json['name']!,
      email: json['email']!,
      userRole: json['userRole'] == 'customer'
          ? UserRole.customer
          : UserRole.salonOwner,
    );
  }

  set setFavoriteSalons(String salons) {
    favoriteSalons.add(salons);
  }

  List<String> get getFavoriteSalons {
    return favoriteSalons;
  }
}
