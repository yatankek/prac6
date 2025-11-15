import 'package:bloc/bloc.dart';
import 'package:prac6/features/menu/data/repositories/cart_repository.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/features/menu/data/bloc/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit()
      : _cartRepository = getIt<CartRepository>(),
        super(const CartState());

  void loadCart() {
    emit(state.copyWith(isLoading: true));

    final cartItems = _cartRepository.getCartItems();
    final totalPrice = _cartRepository.getTotalPrice();

    emit(CartState(
      cartItems: cartItems,
      totalPrice: totalPrice,
      itemCount: cartItems.length,
      isLoading: false,
    ));
  }

  void addToCart(String dishId) {
    _cartRepository.addToCart(dishId);
    loadCart();
  }

  void removeFromCart(String dishId) {
    _cartRepository.removeFromCart(dishId);
    loadCart();
  }

  void clearCart() {
    final cartItems = _cartRepository.getCartItems();
    for (final dish in cartItems) {
      _cartRepository.removeFromCart(dish.id);
    }
    loadCart();
  }
}