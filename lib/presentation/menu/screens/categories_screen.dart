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
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                context.push('/profile');
              },
              tooltip: 'Профиль',
            ),
          ],
        ),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD32F2F)),
                ),
              );
            }

            return Column(
              children: [
                // Категории в виде горизонтального списка
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      final isSelected = _currentPage == index;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: ChoiceChip(
                          label: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFFD32F2F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _currentPage = index;
                              context.read<CategoriesCubit>().selectCategory(category);
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          backgroundColor: Colors.white,
                          selectedColor: const Color(0xFFD32F2F),
                          side: BorderSide(
                            color: const Color(0xFFD32F2F).withValues(alpha: 0.5),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // Индикатор текущей категории
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Категория: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        state.selectedCategory,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${state.displayDishes.length} блюд',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Разделитель
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),

                // Список блюд в виде PageView
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                        final category = state.categories[index];
                        context.read<CategoriesCubit>().selectCategory(category);
                      });
                    },
                    children: state.categories.map((category) {
                      final categoryDishes = category == 'Все'
                          ? state.dishes
                          : state.dishes.where((dish) => dish.name.contains(category)).toList();

                      if (categoryDishes.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant_menu,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'В этой категории пока нет блюд',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: categoryDishes.length,
                        itemBuilder: (context, index) {
                          final dish = categoryDishes[index];
                          return DishCard(
                            dish: dish,
                            onTap: () {
                              context.push(
                                '/dish/${dish.id}',
                                extra: dish,
                              );
                            },
                            onFavoritePressed: () {
                              context.read<FavoritesCubit>().toggleFavorite(dish.id);
                              appState.refreshUI();
                            },
                            onCartPressed: () {
                              final cartCubit = context.read<CartCubit>();
                              final isCurrentlyInCart = cartCubit.state.cartItems
                                  .any((item) => item.id == dish.id);

                              if (isCurrentlyInCart) {
                                cartCubit.removeFromCart(dish.id);
                              } else {
                                cartCubit.addToCart(dish.id);
                              }
                              appState.refreshUI();
                            },
                          );
                        },
                      );
                    }).toList(),
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