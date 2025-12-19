import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/cart_repository.dart';

/// Use Case: Получить товары в корзине
class GetCartItems {
  final CartRepository _cartRepository;

  GetCartItems(this._cartRepository);

  Future<List<Dish>> call() {
    return _cartRepository.getCartItems();
  }
}



