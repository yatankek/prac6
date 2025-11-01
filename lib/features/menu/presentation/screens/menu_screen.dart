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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              context.push('/categories');
            },
            tooltip: 'Категории',
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              context.push('/favorites');
            },
            tooltip: 'Избранное',
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.push('/profile');
            },
            tooltip: 'Профиль',
          ),
        ],
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
          context.push('/cart');
        },
        backgroundColor: const Color(0xFFD32F2F),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}