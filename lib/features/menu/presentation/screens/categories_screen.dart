import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/features/menu/data/models/dish_model.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';
import 'package:prac6/service_locator.dart';
import 'package:prac6/app_state.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> categories = ['Все', 'Паста', 'Пицца', 'Гриль', 'Салаты', 'Десерты'];

  @override
  Widget build(BuildContext context) {
    final menuRepository = getIt<MenuRepository>();
    final appState = AppState.of(context);

    List<Dish> _getDishesByCategory(String category) {
      if (category == 'Все') {
        return menuRepository.getAllDishes();
      }
      return menuRepository.getAllDishes().where((dish) => dish.name.contains(category)).toList();
    }

    return Scaffold(
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
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: _currentPage == index,
                    onSelected: (selected) {
                      setState(() {
                        _currentPage = index;
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: categories.map((category) {
                final categoryDishes = _getDishesByCategory(category);
                return ListView.builder(
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
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}