import 'package:flutter/material.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'dish_detail_screen.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
              );
            },
            tooltip: 'Категории',
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
            tooltip: 'Избранное',
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DishDetailScreen(dish: dish)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        backgroundColor: const Color(0xFFD32F2F),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}