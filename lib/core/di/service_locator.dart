import 'package:get_it/get_it.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/features/menu/data/repositories/cart_repository.dart';
import 'package:prac6/features/menu/data/repositories/favorites_repository.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<MenuRepository>(() => MenuRepository());
  getIt.registerLazySingleton<CartRepository>(() => CartRepository(getIt<MenuRepository>()));
  getIt.registerLazySingleton<FavoritesRepository>(() => FavoritesRepository(getIt<MenuRepository>()));

  getIt.allowReassignment = true;
}