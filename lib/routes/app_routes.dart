import 'package:ecommerce/Screens/homescreen.dart';
import 'package:get/get.dart';
import '../Onboading/onboarding_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/register_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/register', page: () => RegisterScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
  ];
}
