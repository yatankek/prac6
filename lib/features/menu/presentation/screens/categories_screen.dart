import 'package:flutter/material.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/presentation/screens/menu_screen.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';
import 'package:prac6/features/menu/data/models/dish_model.dart';
import 'package:prac6/features/menu/presentation/screens/dish_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final MenuRepository _repository = MenuRepository();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> categories = ['Все', 'Паста', 'Пицца', 'Гриль', 'Салаты', 'Десерты'];

  List<Dish> _getDishesByCategory(String category) {
    if (category == 'Все') {
      return _repository.getAllDishes();
    }
    return _repository.getAllDishes().where((dish) => dish.name.contains(category)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DishDetailScreen(dish: dish)),
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