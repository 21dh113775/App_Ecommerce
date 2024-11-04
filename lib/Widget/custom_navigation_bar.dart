import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  const CustomNavigationBar({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.search, size: 30),
        Icon(Icons.category, size: 30),
        Icon(Icons.shopping_cart, size: 30),
        Icon(Icons.person, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: onTap,
    );
  }
}
