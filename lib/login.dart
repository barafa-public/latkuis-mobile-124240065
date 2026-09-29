import 'package:flutter/material.dart';

import 'models/data.dart';
import 'root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';
  bool _isError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // 1. Validasi input kosong
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _isError = true;
        _errorMessage = 'Username dan password tidak boleh kosong';
      });
      return;
    }

    // 2. Cek kredensial dengan data user1 dari data.dart
    if (username == user1.username && password == user1.password) {
      setState(() {
        _isError = false;
        _errorMessage = '';
      });

      // 3. Berhasil: pindah ke Root (Home & Profile), username ikut dikirim
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Root(username: username)),
      );
    } else {
      setState(() {
        _isError = true;
        _errorMessage = 'Username atau password salah';
      });
    }
  }

  // Decoration
  InputDecoration _fieldDecoration(String hint) {
    final outline = Theme.of(context).colorScheme.outline;

    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: color),
    );

    return InputDecoration(
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: border(_isError ? Colors.red : outline),
      focusedBorder: border(_isError ? Colors.red : Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'lib/assets/images/LogoMieGacoan.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 20),

                const Text(
                  'Selamat Datang di Gacoan',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),

                // Username
                TextField(
                  controller: _usernameController,
                  style: const TextStyle(fontSize: 14),
                  decoration: _fieldDecoration('username'),
                ),
                const SizedBox(height: 16),

                // Password (tersembunyi)
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(fontSize: 14),
                  decoration: _fieldDecoration('password'),
                ),

                // Pesan error
                if (_isError) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
                const SizedBox(height: 16),

                // Tombol login
                SizedBox(
                  width: 175,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
