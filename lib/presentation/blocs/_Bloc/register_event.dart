import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  RegisterSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterWithEmail extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithEmail(this.email, this.password);
}

class RegisterWithGoogle extends RegisterEvent {}  // Thêm sự kiện này