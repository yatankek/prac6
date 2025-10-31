import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';

class MenuScreen extends StatelessWidget {
  final MenuRepository _repository = MenuRepository();

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dishes = _repository.getAllDishes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Меню Ресторана'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFD32F2F)),
              child: Text('Навигация', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Категории'),
              onTap: () {
                context.pop();
                context.push('/categories');
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Избранное'),
              onTap: () {
                context.pop();
                context.push('/favorites');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Профиль'),
              onTap: () {
                context.pop();
                context.push('/profile');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          final dish = dishes[index];
          return DishCard(
            dish: dish,
            onTap: () {
              context.push(
                '/dish/${dish.id}',
                extra: dish,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/cart');
        },
        backgroundColor: const Color(0xFFD32F2F),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}