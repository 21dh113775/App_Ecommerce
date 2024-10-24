import 'package:ecommerce/Screens/forgot_password_screen.dart';
import 'package:ecommerce/Screens/homescreen.dart';
import 'package:ecommerce/Screens/register_screen.dart';
import 'package:ecommerce/Utils/snackbar_utils.dart';
import 'package:ecommerce/presentation/blocs/Login_Bloc/login_bloc.dart';
import 'package:ecommerce/presentation/blocs/Login_Bloc/login_event.dart';
import 'package:ecommerce/presentation/blocs/Login_Bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(LoginSubmitted(
            email: _usernameController.text,
            password: _passwordController.text,
          ));
    }
  }

  void _onGoogleLoginPressed() {
    context.read<LoginBloc>().add(LoginWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Tên đăng nhập',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên đăng nhập';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Get.offAll(() => HomeScreen());
                        SnackbarUtils.showSuccessSnackBar(
                            context, 'Đăng nhập thành công!');
                      } else if (state is LoginFailure) {
                        SnackbarUtils.showErrorSnackBar(context, state.error);
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is LoginLoading
                              ? null
                              : _onLoginButtonPressed,
                          child: state is LoginLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text('Đăng Nhập'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.to(() => ForgotPasswordScreen()),
                      child: Text('Quên mật khẩu?'),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Hoặc'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return OutlinedButton.icon(
                        onPressed: state is LoginLoading
                            ? null
                            : _onGoogleLoginPressed,
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 24,
                        ),
                        label: Text('Đăng nhập với Google'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bạn chưa có tài khoản? '),
                      TextButton(
                        onPressed: () => Get.to(() => RegisterScreen()),
                        child: Text('Đăng ký'),
                      ),
                    ],
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
      ),
    );
  }
}
