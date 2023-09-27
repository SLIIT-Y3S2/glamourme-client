class DemoModel {
  final String name;
  final String email;

  DemoModel({required this.name, required this.email});

  factory DemoModel.fromJson(Map<String, dynamic> json) {
    return DemoModel(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
