import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final categories = [
    {'name': 'Thời trang', 'icon': Icons.checkroom},
    {'name': 'Điện tử', 'icon': Icons.devices},
    {'name': 'Nội thất', 'icon': Icons.chair},
    {'name': 'Sách', 'icon': Icons.book},
    {'name': 'Khác', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh mục',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: categories.map((category) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    category['name'] as String,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
