import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If user cancels the sign in process
      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Return the UserCredential
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
      return null;
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra trong quá trình đăng nhập: $e',
        backgroundColor:
            Colors.red.withOpacity(0.1), // Replace with a specific color
        duration: Duration(seconds: 3),
      );
      return null;
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'account-exists-with-different-credential':
        message = 'Tài khoản này đã tồn tại với phương thức đăng nhập khác';
        break;
      case 'invalid-credential':
        message = 'Thông tin đăng nhập không hợp lệ';
        break;
      case 'operation-not-allowed':
        message = 'Đăng nhập bằng Google chưa được kích hoạt';
        break;
      case 'user-disabled':
        message = 'Tài khoản đã bị vô hiệu hóa';
        break;
      case 'user-not-found':
        message = 'Không tìm thấy tài khoản';
        break;
      default:
        message = 'Đã có lỗi xảy ra: ${e.message}';
    }
    Get.snackbar(
      'Lỗi',
      message,
      backgroundColor:
          Colors.red.withOpacity(0.1), // Replace with a specific color
      duration: Duration(seconds: 3),
    );
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra khi đăng xuất: $e',
        backgroundColor:
            Colors.red.withOpacity(0.1), // Replace with a specific color
      );
    }
  }
}
