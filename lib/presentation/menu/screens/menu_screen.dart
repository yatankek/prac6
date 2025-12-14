import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/presentation/menu/cubit/menu_cubit.dart';
import 'package:prac6/presentation/menu/cubit/cart_cubit.dart';
import 'package:prac6/presentation/menu/cubit/favorites_cubit.dart';
import 'package:prac6/presentation/menu/cubit/menu_state.dart';
import 'package:prac6/presentation/menu/widgets/dish_card.dart';
import 'package:prac6/app_state.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/domain/usecases/get_all_dishes.dart';
import 'package:prac6/domain/usecases/search_dishes.dart';
import 'package:prac6/domain/usecases/get_cart_items.dart';
import 'package:prac6/domain/usecases/get_cart_total.dart';
import 'package:prac6/domain/usecases/add_to_cart.dart';
import 'package:prac6/domain/usecases/remove_from_cart.dart';
import 'package:prac6/domain/usecases/clear_cart.dart';
import 'package:prac6/domain/usecases/get_favorites.dart';
import 'package:prac6/domain/usecases/add_to_favorites.dart';
import 'package:prac6/domain/usecases/remove_from_favorites.dart';
import 'package:prac6/domain/usecases/check_is_favorite.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MenuCubit(
            getAllDishes: getIt<GetAllDishes>(),
            searchDishes: getIt<SearchDishes>(),
          )..loadMenu(),
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
        BlocProvider(
          create: (context) => FavoritesCubit(
            getFavorites: getIt<GetFavorites>(),
            addToFavorites: getIt<AddToFavorites>(),
            removeFromFavorites: getIt<RemoveFromFavorites>(),
            checkIsFavorite: getIt<CheckIsFavorite>(),
          )..loadFavorites(),
        ),
      ],
      child: const MenuView(),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Меню Ресторана'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              context.push('/categories');
            },
            tooltip: 'Категории',
          ),
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
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.push('/profile');
            },
            tooltip: 'Профиль',
          ),
        ],
      ),
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Поиск блюд...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) async {
                    await context.read<MenuCubit>().searchDishes(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.displayDishes.length,
                  itemBuilder: (context, index) {
                    final dish = state.displayDishes[index];
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
                        if (cartCubit.state.cartItems.any((item) => item.id == dish.id)) {
                          cartCubit.removeFromCart(dish.id);
                        } else {
                          cartCubit.addToCart(dish.id);
                        }
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/cart');
        },
        backgroundColor: const Color(0xFFD32F2F),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}