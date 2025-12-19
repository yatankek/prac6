import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac6/app_state.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/core/observer/counter_observer.dart';
import 'package:prac6/core/routing/app_router.dart';
import 'package:prac6/presentation/settings/bloc/settings_cubit.dart';
import 'package:prac6/presentation/auth/bloc/auth_cubit.dart';
import 'package:prac6/domain/repositories/settings_repository.dart';
import 'package:prac6/presentation/menu/cubit/cart_cubit.dart';
import 'package:prac6/presentation/menu/cubit/favorites_cubit.dart';
import 'package:prac6/domain/usecases/get_cart_items.dart';
import 'package:prac6/domain/usecases/get_cart_total.dart';
import 'package:prac6/domain/usecases/add_to_cart.dart';
import 'package:prac6/domain/usecases/remove_from_cart.dart';
import 'package:prac6/domain/usecases/clear_cart.dart';
import 'package:prac6/domain/usecases/get_favorites.dart';
import 'package:prac6/domain/usecases/add_to_favorites.dart';
import 'package:prac6/domain/usecases/remove_from_favorites.dart';
import 'package:prac6/domain/usecases/check_is_favorite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  Bloc.observer = const CounterObserver();
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(getIt<SettingsRepository>()),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(
            getCartItems: getIt<GetCartItems>(),
            getCartTotal: getIt<GetCartTotal>(),
            addToCart: getIt<AddToCart>(),
            removeFromCart: getIt<RemoveFromCart>(),
            clearCart: getIt<ClearCart>(),
          )..loadCart(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(
            getFavorites: getIt<GetFavorites>(),
            addToFavorites: getIt<AddToFavorites>(),
            removeFromFavorites: getIt<RemoveFromFavorites>(),
            checkIsFavorite: getIt<CheckIsFavorite>(),
          )..loadFavorites(),
        ),
      ],
      child: AppStateContainer(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            return MaterialApp.router(
              title: 'Ресторанное приложение',
              theme: ThemeData(
                primaryColor: const Color(0xFFD32F2F),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                ),
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFD32F2F),
                  brightness: Brightness.light,
                ),
              ),
              darkTheme: ThemeData(
                primaryColor: const Color(0xFFD32F2F),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                ),
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFD32F2F),
                  brightness: Brightness.dark,
                ),
              ),
              themeMode: settingsState.themeMode,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}