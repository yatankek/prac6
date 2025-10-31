import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            context.pop();
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
              child: Icon(Icons.person, size: 40),
            ),
            decoration: BoxDecoration(color: Color(0xFFD32F2F)),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('История заказов'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Избранное'),
            onTap: () {
              context.push('/favorites');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Настройки'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Помощь'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}