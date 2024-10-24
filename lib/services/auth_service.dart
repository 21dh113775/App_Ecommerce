import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign up with email/password
  Future<UserCredential?> signUpWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
      return null;
    }
  }

  // Sign in with email/password
  Future<UserCredential?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
      return null;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
      return null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred during Google sign-in: $e',
        backgroundColor: Colors.red.withOpacity(0.1),
        duration: Duration(seconds: 3),
      );
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while signing out: $e',
        backgroundColor: Colors.red.withOpacity(0.1),
      );
    }
  }

  // Handle FirebaseAuth errors
  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'account-exists-with-different-credential':
        message =
            'This account already exists with a different sign-in method.';
        break;
      case 'invalid-credential':
        message = 'Invalid credentials.';
        break;
      case 'operation-not-allowed':
        message = 'Google sign-in is not enabled.';
        break;
      case 'user-disabled':
        message = 'The user account has been disabled.';
        break;
      case 'user-not-found':
        message = 'No account found for this email.';
        break;
      default:
        message = 'An error occurred: ${e.message}';
    }
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red.withOpacity(0.1),
      duration: Duration(seconds: 3),
    );
  }
}
