import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/services/google_auth_service.dart';
import 'package:ecommerce/routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _googleAuthService = GoogleAuthService();

  bool _isLoading = false;
  bool _isGoogleSignInLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  Future<void> _handleRegister() async {
    // Kiểm tra nếu form chưa hợp lệ thì ngừng lại
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Đăng ký người dùng mới với Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Gửi email xác thực
        await userCredential.user!.sendEmailVerification();

        // Hiển thị thông báo thành công
        Get.snackbar(
          'Thành công',
          'Đăng ký thành công! Vui lòng kiểm tra email để xác thực tài khoản.',
          backgroundColor: Colors.green[100],
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.TOP,
        );

        // Di chuyển đến màn hình đăng nhập sau khi gửi liên kết xác thực
        Get.offAllNamed('/login'); // Điều hướng tới trang đăng nhập
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Đã có lỗi xảy ra';

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email này đã được sử dụng';
          break;
        case 'weak-password':
          errorMessage = 'Mật khẩu quá yếu';
          break;
        case 'invalid-email':
          errorMessage = 'Email không hợp lệ';
          break;
        default:
          errorMessage = 'Lỗi: ${e.message}';
      }

      // Hiển thị thông báo lỗi
      Get.snackbar(
        'Lỗi',
        errorMessage,
        backgroundColor: Colors.red[100],
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      // Hiển thị thông báo lỗi chung
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra. Vui lòng thử lại sau.',
        backgroundColor: Colors.red[100],
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isGoogleSignInLoading = true;
    });

    try {
      final userCredential = await _googleAuthService.signInWithGoogle();

      if (userCredential?.user != null) {
        if (userCredential!.user!.emailVerified) {
          Get.snackbar(
            'Thành công',
            'Đăng ký bằng Google thành công!',
            backgroundColor: Colors.green.withOpacity(0.1),
            duration: Duration(seconds: 3),
          );
          Get.offAll(() => AppRoutes.routes);
        } else {
          Get.snackbar(
            'Xác thực email',
            'Vui lòng xác thực email của bạn trước khi tiếp tục.',
            backgroundColor: Colors.orange.withOpacity(0.1),
            duration: Duration(seconds: 5),
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đăng nhập Google không thành công. Vui lòng thử lại.',
        backgroundColor: Colors.red.withOpacity(0.1),
        duration: Duration(seconds: 3),
      );
    } finally {
      setState(() {
        _isGoogleSignInLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Image.asset(
                  'assets/images/logo.png',
                  height: 180,
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Mật khẩu',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: _validatePassword,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Nhập lại mật khẩu',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text('Đăng Ký'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bạn đã có tài khoản? '),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Đăng nhập'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed:
                      _isGoogleSignInLoading ? null : _handleGoogleSignIn,
                  icon: _isGoogleSignInLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Image.asset(
                          'assets/images/google.png',
                          height: 24,
                        ),
                  label: Text('Login with Google'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                SizedBox(height: 100),
                Center(
                  child: Text(
                    'Online Store For Everyone',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
