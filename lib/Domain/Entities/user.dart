// lib/domain/entities/user.dart

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String firebaseId; // Thêm trường firebaseId
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String passwordHash; // Thêm trường passwordHash

  const User({
    this.id,
    required this.firebaseId,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.passwordHash, // Thêm trường này
  });

  // Phương thức để tạo một bản sao của User với các thuộc tính cập nhật
  User copyWith({
    int? id,
    String? firebaseId,
    String? username,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? passwordHash, // Thêm trường này
  }) {
    return User(
      id: id ?? this.id,
      firebaseId: firebaseId ?? this.firebaseId, // Thêm trường này
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      passwordHash: passwordHash ?? this.passwordHash, // Thêm trường này
    );
  }

  // Phương thức để kiểm tra xem email có hợp lệ không
  bool isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Phương thức để kiểm tra xem số điện thoại có hợp lệ không
  bool isValidPhoneNumber() {
    return RegExp(r'^\+?[0-9]{10,14}$').hasMatch(phoneNumber);
  }

  @override
  List<Object?> get props => [
        id,
        firebaseId, // Thêm trường này
        username,
        email,
        fullName,
        phoneNumber,
        address,
        createdAt,
        updatedAt,
        passwordHash, // Thêm trường này
      ];

  @override
  bool get stringify => true;
}
