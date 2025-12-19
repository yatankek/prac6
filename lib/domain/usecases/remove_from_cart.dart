import 'package:prac6/domain/repositories/cart_repository.dart';

/// Use Case: Удалить блюдо из корзины
class RemoveFromCart {
  final CartRepository _cartRepository;

  RemoveFromCart(this._cartRepository);

  Future<void> call(String dishId) {
    return _cartRepository.removeFromCart(dishId);
  }
}



