import 'package:flutter/material.dart';

import 'models/data.dart';

// SEMENTARA: placeholder agar klik menu di Home bisa diuji.
// Akan disempurnakan (gambar besar, kategori, harga, deskripsi).
class DetailPage extends StatelessWidget {
  final Menu menu;

  const DetailPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(menu.name)),
      body: Center(child: Text('Detail ${menu.name} (belum dibuat)')),
    );
  }
}
