import 'package:prac6/domain/repositories/cart_repository.dart';

/// Use Case: Получить общую стоимость корзины
class GetCartTotal {
  final CartRepository _cartRepository;

  GetCartTotal(this._cartRepository);

  Future<double> call() {
    return _cartRepository.getTotalPrice();
  }
}



