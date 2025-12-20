import 'package:go_router/go_router.dart';
import 'package:prac6/core/models/dish.dart';
import 'package:prac6/presentation/menu/screens/menu_screen.dart';
import 'package:prac6/presentation/menu/screens/cart_screen.dart';
import 'package:prac6/presentation/menu/screens/categories_screen.dart';
import 'package:prac6/presentation/menu/screens/favorites_screen.dart';
import 'package:prac6/presentation/profile/screens/profile_screen.dart';
import 'package:prac6/presentation/settings/screens/settings_screen.dart';
import 'package:prac6/presentation/menu/screens/dish_detail_screen.dart';
import 'package:prac6/presentation/auth/screens/auth_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'menu',
        builder: (context, state) => const MenuScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/categories',
        name: 'categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/dish/:id',
        name: 'dishDetail',
        builder: (context, state) {
          final dish = state.extra as Dish;
          return DishDetailScreen(dish: dish);
        },
      ),
    ],
  );
}