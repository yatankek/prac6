import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/presentation/menu/cubit/favorites_cubit.dart';
import 'package:prac6/presentation/menu/cubit/cart_cubit.dart';
import 'package:prac6/presentation/menu/cubit/favorites_state.dart';
import 'package:prac6/presentation/menu/widgets/dish_card.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/domain/usecases/get_favorites.dart';
import 'package:prac6/domain/usecases/add_to_favorites.dart';
import 'package:prac6/domain/usecases/remove_from_favorites.dart';
import 'package:prac6/domain/usecases/check_is_favorite.dart';
import 'package:prac6/domain/usecases/get_cart_items.dart';
import 'package:prac6/domain/usecases/get_cart_total.dart';
import 'package:prac6/domain/usecases/add_to_cart.dart';
import 'package:prac6/domain/usecases/remove_from_cart.dart';
import 'package:prac6/domain/usecases/clear_cart.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoritesCubit(
            getFavorites: getIt<GetFavorites>(),
            addToFavorites: getIt<AddToFavorites>(),
            removeFromFavorites: getIt<RemoveFromFavorites>(),
            checkIsFavorite: getIt<CheckIsFavorite>(),
          )..loadFavorites(),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            getCartItems: getIt<GetCartItems>(),
            getCartTotal: getIt<GetCartTotal>(),
            addToCart: getIt<AddToCart>(),
            removeFromCart: getIt<RemoveFromCart>(),
            clearCart: getIt<ClearCart>(),
          )..loadCart(),
        ),
      ],
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return state.favorites.isEmpty
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
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final dish = state.favorites[index];
              return DishCard(
                dish: dish,
                onTap: () {
                  context.push(
                    '/dish/${dish.id}',
                    extra: dish,
                  );
                },
                onFavoritePressed: () {
                  final favoritesCubit = context.read<FavoritesCubit>();
                  favoritesCubit.removeFromFavorites(dish.id);
                },
                onCartPressed: () {
                  final cartCubit = context.read<CartCubit>();
                  if (cartCubit.state.cartItems.any((item) => item.id == dish.id)) {
                    cartCubit.removeFromCart(dish.id);
                  } else {
                    cartCubit.addToCart(dish.id);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}