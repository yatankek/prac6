import 'package:bloc/bloc.dart';
import 'package:prac6/presentation/menu/cubit/menu_state.dart';
import 'package:prac6/domain/usecases/get_all_dishes.dart';
import 'package:prac6/domain/usecases/search_dishes.dart';

/// Cubit для управления состоянием меню
/// Использует Use Cases для выполнения бизнес-операций
class MenuCubit extends Cubit<MenuState> {
  final GetAllDishes _getAllDishes;
  final SearchDishes _searchDishes;

  MenuCubit({
    required GetAllDishes getAllDishes,
    required SearchDishes searchDishes,
  })  : _getAllDishes = getAllDishes,
        _searchDishes = searchDishes,
        super(const MenuState());

  /// Загрузить меню
  Future<void> loadMenu() async {
    emit(state.copyWith(isLoading: true));

    try {
      final dishes = await _getAllDishes();
      emit(state.copyWith(
        dishes: dishes,
        filteredDishes: dishes,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // В реальном приложении здесь можно обработать ошибку
    }
  }

  /// Поиск блюд
  Future<void> searchDishes(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(
        filteredDishes: state.dishes,
        searchQuery: query,
      ));
      return;
    }

    try {
      final filteredDishes = await _searchDishes(query);
      emit(state.copyWith(
        filteredDishes: filteredDishes,
        searchQuery: query,
      ));
    } catch (e) {
      // В реальном приложении здесь можно обработать ошибку
    }
  }
}

