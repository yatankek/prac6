import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac6/core/models/dish.dart';
import 'package:prac6/presentation/menu/cubit/cart_state.dart';
import 'package:prac6/presentation/menu/cubit/favorites_cubit.dart';
import 'package:prac6/presentation/menu/cubit/cart_cubit.dart';
import 'package:prac6/presentation/menu/cubit/favorites_state.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onTap;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onCartPressed;

  const DishCard({
    super.key,
    required this.dish,
    required this.onTap,
    this.onFavoritePressed,
    this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, favoritesState) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            final isFavorite = favoritesState.favorites.any((fav) => fav.id == dish.id);
            final isInCart = cartState.cartItems.any((item) => item.id == dish.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: dish.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.restaurant, color: Colors.grey),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.red[100],
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dish.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: onFavoritePressed,
                        ),
                        IconButton(
                          icon: Icon(
                            isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                            color: isInCart ? Colors.green : Colors.grey,
                          ),
                          onPressed: onCartPressed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                dish.formattedPrice,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD32F2F),
                ),
              ),
            ],
          ),
        ),
      ),
            );
          },
        );
      },
    );
  }
}