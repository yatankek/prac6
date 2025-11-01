import 'package:prac6/features/menu/data/models/dish_model.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';

class CartRepository {
  final MenuRepository _menuRepository;
  final List<String> _cartItemIds = ['2', '4'];

  CartRepository(this._menuRepository);

  List<Dish> getCartItems() {
    return _cartItemIds.map((id) => _menuRepository.getDishById(id)).toList();
  }

  double getTotalPrice() {
    return getCartItems().fold(0, (sum, dish) => sum + dish.price);
  }
}