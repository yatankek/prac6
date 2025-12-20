// lib/presentation/menu/screens/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/presentation/menu/cubit/categories_cubit.dart';
import 'package:prac6/presentation/menu/cubit/cart_cubit.dart';
import 'package:prac6/presentation/menu/cubit/categories_state.dart';
import 'package:prac6/presentation/menu/cubit/favorites_cubit.dart';
import 'package:prac6/presentation/menu/widgets/dish_card.dart';
import 'package:prac6/app_state.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/domain/usecases/get_all_dishes.dart';
import 'package:prac6/domain/usecases/get_categories.dart';
import 'package:prac6/domain/usecases/get_dishes_by_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return BlocProvider(
      create: (context) => CategoriesCubit(
        getAllDishes: getIt<GetAllDishes>(),
        getCategories: getIt<GetCategories>(),
        getDishesByCategory: getIt<GetDishesByCategory>(),
      )..loadCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Категории'),
          backgroundColor: const Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    context.push('/favorites');
                  },
                  tooltip: 'Избранное',
                ),
                if (appState.favoriteCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        appState.favoriteCount.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    context.push('/cart');
                  },
                  tooltip: 'Корзина',
                ),
                if (appState.cartItemsCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.green,
                      child: Text(
                        appState.cartItemsCount.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state.isLoading && state.categories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      final isSelected = category == state.selectedCategory;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<CategoriesCubit>().selectCategory(category);
                            }
                          },
                          selectedColor: const Color(0xFFD32F2F),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: state.filteredDishes.length,
                          itemBuilder: (context, index) {
                            final dish = state.filteredDishes[index];
                            return DishCard(
                              dish: dish,
                              onTap: () {
                                context.push('/dish/${dish.id}', extra: dish);
                              },
                              onCartPressed: () {
                                context.read<CartCubit>().addToCart(dish.id);
                                appState.refreshUI();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${dish.name} добавлено в корзину'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              onFavoritePressed: () {
                                context.read<FavoritesCubit>().toggleFavorite(dish.id);
                                appState.refreshUI();
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
