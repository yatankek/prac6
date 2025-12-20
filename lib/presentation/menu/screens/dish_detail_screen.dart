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
import 'package:prac6/domain/usecases/get_dish_by_id.dart';

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
        getDishById: getIt<GetDishById>(),
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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (dish.imageUrl.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: dish.imageUrl,
                    height: 250,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 250,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 250,
                      color: Colors.grey[200],
                      child: const Icon(Icons.error),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              dish.name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            dish.formattedPrice,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: const Color(0xFFD32F2F),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Описание',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      state.isLoading 
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                              dish.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<DishDetailCubit>().toggleCart();
                            appState.refreshUI();
                            if (!state.isInCart) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Добавлено в корзину'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.isInCart ? Colors.grey : const Color(0xFFD32F2F),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            state.isInCart ? 'Убрать из корзины' : 'В корзину',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
