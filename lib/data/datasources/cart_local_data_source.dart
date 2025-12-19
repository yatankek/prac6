import 'package:prac6/data/datasources/app_database.dart';
import 'package:drift/drift.dart';

/// Локальный источник данных для корзины
abstract class CartLocalDataSource {
  /// Получить ID всех товаров в корзине
  Future<List<String>> getCartItemIds();

  /// Добавить товар в корзину
  Future<void> addItem(String dishId);

  /// Удалить товар из корзины
  Future<void> removeItem(String dishId);

  /// Проверить наличие товара в корзине
  Future<bool> isItemInCart(String dishId);

  /// Получить количество товаров
  Future<int> getItemsCount();

  /// Очистить корзину
  Future<void> clear();
}

/// Drift реализация источника данных корзины
class CartLocalDataSourceImpl implements CartLocalDataSource {
  final AppDatabase database;

  CartLocalDataSourceImpl({required this.database});

  @override
  Future<List<String>> getCartItemIds() async {
    final items = await database.select(database.cartItems).get();
    return items.map((item) => item.dishId).toList();
  }

  @override
  Future<void> addItem(String dishId) async {
    await database.into(database.cartItems).insertOnConflictUpdate(
      CartItemsCompanion(dishId: Value(dishId))
    );
  }

  @override
  Future<void> removeItem(String dishId) async {
    await (database.delete(database.cartItems)..where((t) => t.dishId.equals(dishId))).go();
  }

  @override
  Future<bool> isItemInCart(String dishId) async {
    final query = database.select(database.cartItems)..where((t) => t.dishId.equals(dishId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  @override
  Future<int> getItemsCount() async {
    final countExp = database.cartItems.dishId.count();
    final query = database.selectOnly(database.cartItems)..addColumns([countExp]);
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }

  @override
  Future<void> clear() async {
    await database.delete(database.cartItems).go();
  }
}



