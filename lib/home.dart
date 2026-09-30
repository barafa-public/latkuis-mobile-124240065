import 'package:flutter/material.dart';

import 'detail.dart';
import 'models/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  String _selectedCategory = 'Semua';

  // Kategori diambil otomatis dari data menu (Mie, Dimsum, Minuman)
  late final List<String> _categories = [
    'Semua',
    ...menus.map((menu) => menu.category).toSet(),
  ];

  // Shorting menuu
  List<Menu> get _filteredMenus {
    return menus.where((menu) {
      final matchCategory =
          _selectedCategory == 'Semua' || menu.category == _selectedCategory;
      final matchQuery = menu.name.toLowerCase().contains(
        _query.trim().toLowerCase(),
      );
      return matchCategory && matchQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMenus = _filteredMenus;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          // Kolom pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 14),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari menu...',
                isDense: true,
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _query = '';
                          });
                        },
                      ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Filter kategori
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];

                return ChoiceChip(
                  label: Text(category, style: const TextStyle(fontSize: 12)),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 4),

          // Daftar menu
          Expanded(
            child: filteredMenus.isEmpty
                ? const Center(
                    child: Text(
                      'Menu tidak ditemukan',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredMenus.length,
                    itemBuilder: (context, index) {
                      final menu = filteredMenus[index];

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            menu.image,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          menu.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          '${menu.category} • ${menu.price}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: const Icon(Icons.chevron_right, size: 28),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(menu: menu),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
