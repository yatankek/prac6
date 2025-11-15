import 'package:go_router/go_router.dart';
import 'package:prac6/features/menu/presentation/screens/menu_screen.dart';
import 'package:prac6/features/menu/presentation/screens/cart_screen.dart';
import 'package:prac6/features/menu/presentation/screens/categories_screen.dart';
import 'package:prac6/features/menu/presentation/screens/favorites_screen.dart';
import 'package:prac6/features/profile/presentation/screens/profile_screen.dart';
import 'package:prac6/features/menu/presentation/screens/dish_detail_screen.dart';
import 'package:prac6/features/auth/presentation/screens/auth_screen.dart';
import 'package:prac6/features/menu/data/models/dish_model.dart';

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
        builder: (context, state) => MenuScreen(),
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