import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prac6/data/datasources/app_database.dart';
import 'package:prac6/data/datasources/remote/client/dio_client.dart';
import 'package:prac6/data/datasources/remote/menu_remote_data_source.dart';
import 'package:prac6/data/datasources/remote/user_remote_data_source.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';
import 'package:prac6/domain/repositories/cart_repository.dart';
import 'package:prac6/domain/repositories/favorites_repository.dart';
import 'package:prac6/domain/repositories/settings_repository.dart';
import 'package:prac6/domain/repositories/user_repository.dart';
import 'package:prac6/data/datasources/menu_local_data_source.dart';
import 'package:prac6/data/datasources/cart_local_data_source.dart';
import 'package:prac6/data/datasources/favorites_local_data_source.dart';
import 'package:prac6/data/datasources/settings_local_data_source.dart';
import 'package:prac6/data/repositories/menu_repository_impl.dart';
import 'package:prac6/data/repositories/cart_repository_impl.dart';
import 'package:prac6/data/repositories/favorites_repository_impl.dart';
import 'package:prac6/data/repositories/settings_repository_impl.dart';
import 'package:prac6/data/repositories/user_repository_impl.dart';
import 'package:prac6/domain/usecases/get_all_dishes.dart';
import 'package:prac6/domain/usecases/get_dish_by_id.dart';
import 'package:prac6/domain/usecases/search_dishes.dart';
import 'package:prac6/domain/usecases/get_categories.dart';
import 'package:prac6/domain/usecases/get_dishes_by_category.dart';
import 'package:prac6/domain/usecases/get_cart_items.dart';
import 'package:prac6/domain/usecases/get_cart_total.dart';
import 'package:prac6/domain/usecases/add_to_cart.dart';
import 'package:prac6/domain/usecases/remove_from_cart.dart';
import 'package:prac6/domain/usecases/clear_cart.dart';
import 'package:prac6/domain/usecases/get_favorites.dart';
import 'package:prac6/domain/usecases/add_to_favorites.dart';
import 'package:prac6/domain/usecases/remove_from_favorites.dart';
import 'package:prac6/domain/usecases/check_is_favorite.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  
  // Network
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Data Sources - Remote
  getIt.registerLazySingleton<MenuRemoteDataSource>(
    () => MenuRemoteDataSourceImpl(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt<DioClient>().dio),
  );

  // Data Sources - Local
  getIt.registerLazySingleton<MenuLocalDataSource>(
    () => MenuLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(database: getIt()),
  );
  getIt.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(database: getIt()),
  );
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // Repositories (Domain interfaces)
  getIt.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(getIt<MenuRemoteDataSource>()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      getIt<CartLocalDataSource>(),
      getIt<MenuRepository>(),
    ),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      getIt<FavoritesLocalDataSource>(),
      getIt<MenuRepository>(),
    ),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetAllDishes>(
    () => GetAllDishes(getIt<MenuRepository>()),
  );
  getIt.registerLazySingleton<GetDishById>(
    () => GetDishById(getIt<MenuRepository>()),
  );
  getIt.registerLazySingleton<SearchDishes>(
    () => SearchDishes(getIt<MenuRepository>()),
  );
  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(getIt<MenuRepository>()),
  );
  getIt.registerLazySingleton<GetDishesByCategory>(
    () => GetDishesByCategory(getIt<MenuRepository>()),
  );
  getIt.registerLazySingleton<GetCartItems>(
    () => GetCartItems(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<GetCartTotal>(
    () => GetCartTotal(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<AddToCart>(
    () => AddToCart(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<RemoveFromCart>(
    () => RemoveFromCart(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<ClearCart>(
    () => ClearCart(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<GetFavorites>(
    () => GetFavorites(getIt<FavoritesRepository>()),
  );
  getIt.registerLazySingleton<AddToFavorites>(
    () => AddToFavorites(getIt<FavoritesRepository>()),
  );
  getIt.registerLazySingleton<RemoveFromFavorites>(
    () => RemoveFromFavorites(getIt<FavoritesRepository>()),
  );
  getIt.registerLazySingleton<CheckIsFavorite>(
    () => CheckIsFavorite(getIt<FavoritesRepository>()),
  );
}
