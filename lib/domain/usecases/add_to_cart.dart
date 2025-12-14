import 'package:prac6/domain/repositories/cart_repository.dart';

/// Use Case: Добавить блюдо в корзину
class AddToCart {
  final CartRepository _cartRepository;

  AddToCart(this._cartRepository);

  Future<void> call(String dishId) {
    return _cartRepository.addToCart(dishId);
  }
}

