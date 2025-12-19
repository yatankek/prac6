import 'package:prac6/domain/repositories/cart_repository.dart';

/// Use Case: Очистить корзину
class ClearCart {
  final CartRepository _cartRepository;

  ClearCart(this._cartRepository);

  Future<void> call() {
    return _cartRepository.clearCart();
  }
}



