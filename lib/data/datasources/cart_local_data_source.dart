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

/// In-memory реализация источника данных корзины
class CartLocalDataSourceImpl implements CartLocalDataSource {
  List<String> _cartItemIds = ['2', '4'];

  @override
  Future<List<String>> getCartItemIds() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return List.unmodifiable(_cartItemIds);
  }

  @override
  Future<void> addItem(String dishId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (!_cartItemIds.contains(dishId)) {
      _cartItemIds.add(dishId);
    }
  }

  @override
  Future<void> removeItem(String dishId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _cartItemIds.remove(dishId);
  }

  @override
  Future<bool> isItemInCart(String dishId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _cartItemIds.contains(dishId);
  }

  @override
  Future<int> getItemsCount() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _cartItemIds.length;
  }

  @override
  Future<void> clear() async {
    await Future.delayed(const Duration(milliseconds: 50));
    _cartItemIds.clear();
  }
}

