import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmailPassword(String email, String password);
  Future<User?> signInWithEmailPassword(String email, String password);
  Future<User?> signInWithGoogle();
  Future<void> signOut();
  Stream<User?> get authStateChanges;
}
