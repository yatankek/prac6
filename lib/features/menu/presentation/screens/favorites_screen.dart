import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/features/menu/data/repositories/favorites_repository.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';
import 'package:prac6/service_locator.dart';
import 'package:prac6/app_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesRepository = getIt<FavoritesRepository>();
    final favoriteDishes = favoritesRepository.getFavorites();

    final appState = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: favoriteDishes.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Нет избранных блюд',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: favoriteDishes.length,
        itemBuilder: (context, index) {
          final dish = favoriteDishes[index];
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
    );
  }
}