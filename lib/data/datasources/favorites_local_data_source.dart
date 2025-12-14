/// Локальный источник данных для избранного
abstract class FavoritesLocalDataSource {
  /// Получить ID всех избранных блюд
  Future<List<String>> getFavoriteIds();

  /// Добавить блюдо в избранное
  Future<void> addFavorite(String dishId);

  /// Удалить блюдо из избранного
  Future<void> removeFavorite(String dishId);

  /// Проверить, является ли блюдо избранным
  Future<bool> isFavorite(String dishId);

  /// Получить количество избранных
  Future<int> getFavoritesCount();
}

/// In-memory реализация источника данных избранного
class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  List<String> _favoriteIds = ['1', '5'];

  @override
  Future<List<String>> getFavoriteIds() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return List.unmodifiable(_favoriteIds);
  }

  @override
  Future<void> addFavorite(String dishId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (!_favoriteIds.contains(dishId)) {
      _favoriteIds.add(dishId);
    }
  }

  @override
  Future<void> removeFavorite(String dishId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _favoriteIds.remove(dishId);
  }

  @override
  Future<bool> isFavorite(String dishId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _favoriteIds.contains(dishId);
  }

  @override
  Future<int> getFavoritesCount() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _favoriteIds.length;
  }
}

