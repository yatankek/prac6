import 'package:flutter/material.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';
import 'package:prac6/features/menu/presentation/screens/dish_detail_screen.dart';

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
      body: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          final dish = dishes[index];
          return DishCard(
            dish: dish,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DishDetailScreen(dish: dish),
                ),
              );
            },
          );
        },
      ),
    );
  }
}