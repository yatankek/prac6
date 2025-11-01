import 'package:flutter/material.dart';
import 'package:prac6/features/menu/presentation/screens/auth_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Вертикальный возврат
          },
        ),
      ),
      body: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Иван Иванов'),
            accountEmail: Text('ivan@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Color(0xFFD32F2F)),
            ),
            decoration: BoxDecoration(color: Color(0xFFD32F2F)),
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFFD32F2F)),
            title: const Text('История заказов'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Color(0xFFD32F2F)),
            title: const Text('Избранное'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFFD32F2F)),
            title: const Text('Настройки'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Color(0xFFD32F2F)),
            title: const Text('Помощь'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Выйти',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}