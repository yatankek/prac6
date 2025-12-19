import 'package:prac6/core/models/dish.dart';
abstract class CartRepository {

  Future<List<Dish>> getCartItems();
  Future<double> getTotalPrice();
  Future<void> addToCart(String dishId);
  Future<void> removeFromCart(String dishId);
  Future<bool> isInCart(String dishId);
  Future<int> getCartItemsCount();
  Future<void> clearCart();
}


