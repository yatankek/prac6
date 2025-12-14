import 'package:prac6/core/models/dish.dart';

/// Абстрактный интерфейс репозитория избранного
abstract class FavoritesRepository {
  /// Получить все избранные блюда
  Future<List<Dish>> getFavorites();

  /// Добавить блюдо в избранное
  Future<void> addToFavorites(String dishId);

  /// Удалить блюдо из избранного
  Future<void> removeFromFavorites(String dishId);

  /// Проверить, есть ли блюдо в избранном
  Future<bool> isFavorite(String dishId);

  /// Получить количество избранных блюд
  Future<int> getFavoritesCount();
}

