// sidebar.dart
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class Sidebar extends StatelessWidget {
  final SidebarXController controller;

  const Sidebar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 221, 143, 48),
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        selectedTextStyle:
            TextStyle(color: const Color.fromARGB(255, 42, 38, 26)),
        selectedItemDecoration: BoxDecoration(
          color: const Color.fromARGB(255, 80, 207, 224),
          borderRadius: BorderRadius.circular(10),
        ),
        iconTheme: IconThemeData(color: const Color.fromARGB(179, 19, 19, 19)),
        selectedIconTheme:
            IconThemeData(color: const Color.fromARGB(255, 57, 61, 68)),
        itemTextPadding: const EdgeInsets.only(left: 20),
        itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      ),
      extendedTheme: SidebarXTheme(width: 200),
      headerBuilder: (context, extended) => Container(
        padding: const EdgeInsets.all(30),
        child: Text(
          'E-commerce App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      items: [
        SidebarXItem(icon: Icons.home, label: 'Home'),
        SidebarXItem(icon: Icons.search, label: 'Search'),
        SidebarXItem(icon: Icons.category, label: 'Categories'),
        SidebarXItem(icon: Icons.shopping_cart, label: 'Cart'),
        SidebarXItem(icon: Icons.person, label: 'Profile'),
      ],
    );
  }
}
