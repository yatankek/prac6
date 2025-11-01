import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/features/menu/data/repositories/cart_repository.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartRepository _cartRepository;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
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
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Корзина пуста',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
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
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
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
    );
  }
}