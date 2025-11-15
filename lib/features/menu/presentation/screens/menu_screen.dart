import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/features/menu/data/bloc/menu/menu_cubit.dart';
import 'package:prac6/features/menu/data/bloc/cart/cart_cubit.dart';
import 'package:prac6/features/menu/data/bloc/favorites/favorites_cubit.dart';
import 'package:prac6/features/menu/data/bloc/menu/menu_state.dart';
import 'package:prac6/features/menu/presentation/widgets/dish_card.dart';
import 'package:prac6/app_state.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MenuCubit()..loadMenu()),
        BlocProvider(create: (context) => CartCubit()..loadCart()),
        BlocProvider(create: (context) => FavoritesCubit()..loadFavorites()),
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
                  onChanged: (value) {
                    context.read<MenuCubit>().searchDishes(value);
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
                        final favoritesCubit = context.read<FavoritesCubit>();
                        if (favoritesCubit.state.favorites.any((fav) => fav.id == dish.id)) {
                          favoritesCubit.removeFromFavorites(dish.id);
                        } else {
                          favoritesCubit.addToFavorites(dish.id);
                        }
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