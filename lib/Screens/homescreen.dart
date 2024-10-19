import 'package:ecommerce/Pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import '../Pages/cart_page.dart';
import '../Pages/categories_page.dart';
import '../Pages/home_page.dart';
import '../Pages/profile_page.dart';
import '../Widget/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkModeEnabled = false;
  int _page = 2; // Start with Home selected
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      CategoriesPage(),
      SearchPage(),
      HomePage(),
      CartPage(),
      ProfilePage(signout: signout),
    ];
  }

  signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    } catch (e) {
      print("Lỗi khi đăng xuất: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          DayNightSwitcherIcon(
            isDarkModeEnabled: isDarkModeEnabled,
            onStateChanged: (bool isDarkMode) {
              setState(() {
                isDarkModeEnabled = isDarkMode;
              });
            },
          ),
        ],
      ),
      body: _pages[_page],
      bottomNavigationBar: CustomNavigationBar(
        index: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
