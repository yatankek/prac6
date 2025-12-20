import 'package:prac6/data/datasources/app_database.dart';
import 'package:drift/drift.dart';

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

/// Drift реализация источника данных избранного
class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final AppDatabase database;

  FavoritesLocalDataSourceImpl({required this.database});

  @override
  Future<List<String>> getFavoriteIds() async {
    final items = await database.select(database.favoriteItems).get();
    return items.map((item) => item.dishId).toList();
  }

  @override
  Future<void> addFavorite(String dishId) async {
    await database.into(database.favoriteItems).insertOnConflictUpdate(
      FavoriteItemsCompanion(dishId: Value(dishId))
    );
  }

  @override
  Future<void> removeFavorite(String dishId) async {
    await (database.delete(database.favoriteItems)..where((t) => t.dishId.equals(dishId))).go();
  }

  @override
  Future<bool> isFavorite(String dishId) async {
    final query = database.select(database.favoriteItems)..where((t) => t.dishId.equals(dishId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  @override
  Future<int> getFavoritesCount() async {
    final countExp = database.favoriteItems.dishId.count();
    final query = database.selectOnly(database.favoriteItems)..addColumns([countExp]);
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }
}



