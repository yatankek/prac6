import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/favorites_repository.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';
import 'package:prac6/data/datasources/favorites_local_data_source.dart';

/// Реализация репозитория избранного
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _localDataSource;
  final MenuRepository _menuRepository;

  FavoritesRepositoryImpl(this._localDataSource, this._menuRepository);

  @override
  Future<List<Dish>> getFavorites() async {
    try {
      final favoriteIds = await _localDataSource.getFavoriteIds();
      final dishes = <Dish>[];
      for (final id in favoriteIds) {
        final dish = await _menuRepository.getDishById(id);
        dishes.add(dish);
      }
      return dishes;
    } catch (e) {
      throw Exception('Ошибка при получении избранного: $e');
    }
  }

  @override
  Future<void> addToFavorites(String dishId) async {
    try {
      await _localDataSource.addFavorite(dishId);
    } catch (e) {
      throw Exception('Ошибка при добавлении в избранное: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(String dishId) async {
    try {
      await _localDataSource.removeFavorite(dishId);
    } catch (e) {
      throw Exception('Ошибка при удалении из избранного: $e');
    }
  }

  @override
  Future<bool> isFavorite(String dishId) async {
    try {
      return await _localDataSource.isFavorite(dishId);
    } catch (e) {
      throw Exception('Ошибка при проверке избранного: $e');
    }
  }

  @override
  Future<int> getFavoritesCount() async {
    try {
      return await _localDataSource.getFavoritesCount();
    } catch (e) {
      throw Exception('Ошибка при получении количества избранного: $e');
    }
  }
}

