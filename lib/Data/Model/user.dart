class User {
  final int id;
  final String firebaseId;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String address;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firebaseId,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  // Chuyển đổi từ JSON sang User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firebaseId: json['firebaseId'],
      username: json['username'],
      email: json['email'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Chuyển đổi User object sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firebaseId': firebaseId,
      'username': username,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
