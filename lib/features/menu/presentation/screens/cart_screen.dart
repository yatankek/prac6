import 'package:flutter/material.dart';
import 'package:prac6/features/menu/data/repositories/cart_repository.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';
import 'package:prac6/features/menu/presentation/screens/menu_screen.dart';
import 'package:prac6/features/menu/presentation/screens/categories_screen.dart';
import 'package:prac6/features/menu/presentation/screens/favorites_screen.dart';
import 'package:prac6/features/menu/presentation/screens/profile_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartRepository _cartRepository;

  void _navigateHorizontally(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  void initState() {
    super.initState();
    _cartRepository = CartRepository(MenuRepository());
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = _cartRepository.getCartItems();
    final totalPrice = _cartRepository.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Избранное'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Профиль'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('Корзина пуста'))
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final dish = cartItems[index];
                return DishCard(dish: dish, onTap: () {});
              },
            ),
          ),
          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Итого:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${totalPrice.toInt()} ₽', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F))),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateHorizontally(context, MenuScreen());
        },
        backgroundColor: const Color(0xFFD32F2F),
        child: const Icon(Icons.restaurant_menu, color: Colors.white),
      ),
    );
  }
}