import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/cart_repository.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';
import 'package:prac6/data/datasources/cart_local_data_source.dart';

/// Реализация репозитория корзины
class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _localDataSource;
  final MenuRepository _menuRepository;

  CartRepositoryImpl(this._localDataSource, this._menuRepository);

  @override
  Future<List<Dish>> getCartItems() async {
    try {
      final cartItemIds = await _localDataSource.getCartItemIds();
      final dishes = <Dish>[];
      for (final id in cartItemIds) {
        final dish = await _menuRepository.getDishById(id);
        dishes.add(dish);
      }
      return dishes;
    } catch (e) {
      throw Exception('Ошибка при получении корзины: $e');
    }
  }

  @override
  Future<double> getTotalPrice() async {
    try {
      final cartItems = await getCartItems();
      return cartItems.fold<double>(0.0, (sum, dish) => sum + dish.price);
    } catch (e) {
      throw Exception('Ошибка при расчете стоимости: $e');
    }
  }

  @override
  Future<void> addToCart(String dishId) async {
    try {
      await _localDataSource.addItem(dishId);
    } catch (e) {
      throw Exception('Ошибка при добавлении в корзину: $e');
    }
  }

  @override
  Future<void> removeFromCart(String dishId) async {
    try {
      await _localDataSource.removeItem(dishId);
    } catch (e) {
      throw Exception('Ошибка при удалении из корзины: $e');
    }
  }

  @override
  Future<bool> isInCart(String dishId) async {
    try {
      return await _localDataSource.isItemInCart(dishId);
    } catch (e) {
      throw Exception('Ошибка при проверке корзины: $e');
    }
  }

  @override
  Future<int> getCartItemsCount() async {
    try {
      return await _localDataSource.getItemsCount();
    } catch (e) {
      throw Exception('Ошибка при получении количества: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _localDataSource.clear();
    } catch (e) {
      throw Exception('Ошибка при очистке корзины: $e');
    }
  }
}

