import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/presentation/menu/cubit/dish_detail_cubit.dart';
import 'package:prac6/presentation/menu/cubit/dish_detail_state.dart';
import 'package:prac6/core/models/dish.dart';
import 'package:prac6/app_state.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/domain/usecases/check_is_favorite.dart';
import 'package:prac6/domain/usecases/add_to_favorites.dart';
import 'package:prac6/domain/usecases/remove_from_favorites.dart';
import 'package:prac6/domain/usecases/add_to_cart.dart';
import 'package:prac6/domain/usecases/remove_from_cart.dart';
import 'package:prac6/domain/repositories/cart_repository.dart';

class DishDetailScreen extends StatelessWidget {
  final Dish dish;

  const DishDetailScreen({
    super.key,
    required this.dish,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DishDetailCubit(
        checkIsFavorite: getIt<CheckIsFavorite>(),
        addToFavorites: getIt<AddToFavorites>(),
        removeFromFavorites: getIt<RemoveFromFavorites>(),
        addToCart: getIt<AddToCart>(),
        removeFromCart: getIt<RemoveFromCart>(),
        cartRepository: getIt<CartRepository>(),
      )..loadDish(dish),
      child: const DishDetailView(),
    );
  }
}

class DishDetailView extends StatelessWidget {
  const DishDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<DishDetailCubit, DishDetailState>(
          builder: (context, state) {
            return Text(state.dish?.name ?? '');
          },
        ),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          BlocBuilder<DishDetailCubit, DishDetailState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<DishDetailCubit>().toggleFavorite();
                  appState.refreshUI();
                },
              );
            },
          ),
          BlocBuilder<DishDetailCubit, DishDetailState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<DishDetailCubit>().toggleCart();
                  appState.refreshUI();
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DishDetailCubit, DishDetailState>(
        builder: (context, state) {
          if (state.dish == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final dish = state.dish!;

          return Column(
            children: [
              CachedNetworkImage(
                imageUrl: dish.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 250,
                  color: Colors.grey[200],
                  child: const Icon(Icons.restaurant, size: 50, color: Colors.grey),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 250,
                  color: Colors.red[100],
                  child: const Icon(Icons.error, size: 50, color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dish.description,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      dish.formattedPrice,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}