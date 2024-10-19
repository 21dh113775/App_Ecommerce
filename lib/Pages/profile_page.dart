import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Function signout;

  const ProfilePage({Key? key, required this.signout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Xin chào, ${user?.email ?? ""}'),
          const SizedBox(height: 20),
          Text('UID: ${user?.uid ?? ""}'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => signout(),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}
