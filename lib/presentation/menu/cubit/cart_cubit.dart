import 'package:bloc/bloc.dart';
import 'package:prac6/presentation/menu/cubit/cart_state.dart';
import 'package:prac6/domain/usecases/get_cart_items.dart';
import 'package:prac6/domain/usecases/get_cart_total.dart';
import 'package:prac6/domain/usecases/add_to_cart.dart';
import 'package:prac6/domain/usecases/remove_from_cart.dart';
import 'package:prac6/domain/usecases/clear_cart.dart';

/// Cubit для управления состоянием корзины
class CartCubit extends Cubit<CartState> {
  final GetCartItems _getCartItems;
  final GetCartTotal _getCartTotal;
  final AddToCart _addToCart;
  final RemoveFromCart _removeFromCart;
  final ClearCart _clearCart;

  CartCubit({
    required GetCartItems getCartItems,
    required GetCartTotal getCartTotal,
    required AddToCart addToCart,
    required RemoveFromCart removeFromCart,
    required ClearCart clearCart,
  })  : _getCartItems = getCartItems,
        _getCartTotal = getCartTotal,
        _addToCart = addToCart,
        _removeFromCart = removeFromCart,
        _clearCart = clearCart,
        super(const CartState());

  /// Загрузить корзину
  Future<void> loadCart() async {
    emit(state.copyWith(isLoading: true));

    try {
      final cartItems = await _getCartItems();
      final totalPrice = await _getCartTotal();

      emit(CartState(
        cartItems: cartItems,
        totalPrice: totalPrice,
        itemCount: cartItems.length,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Добавить в корзину
  Future<void> addToCart(String dishId) async {
    try {
      await _addToCart(dishId);
      await loadCart();
    } catch (e) {
      // Обработка ошибки
    }
  }

  /// Удалить из корзины
  Future<void> removeFromCart(String dishId) async {
    try {
      await _removeFromCart(dishId);
      await loadCart();
    } catch (e) {
      // Обработка ошибки
    }
  }

  /// Очистить корзину
  Future<void> clearCart() async {
    try {
      await _clearCart();
      await loadCart();
    } catch (e) {
      // Обработка ошибки
    }
  }
}

