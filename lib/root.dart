import 'package:flutter/material.dart';

// SEMENTARA: placeholder agar login bisa diuji.
// Akan diganti dengan BottomNavigationBar (Home & Profile).
class Root extends StatelessWidget {
  final String username;

  const Root({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(child: Text('Login berhasil sebagai $username')),
    );
  }
}
