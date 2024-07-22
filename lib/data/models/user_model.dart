class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? email;

  User(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
    };
  }
}
