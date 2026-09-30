import 'package:flutter/material.dart';

import 'detail.dart';
import 'models/data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: ListView.builder(
        itemCount: menus.length,
        itemBuilder: (context, index) {
          final menu = menus[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                menu.image,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(menu.name, style: const TextStyle(fontSize: 14)),
            subtitle: Text(
              '${menu.category} • ${menu.price}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, size: 28),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(menu: menu)),
              );
            },
          );
        },
      ),
    );
  }
}
