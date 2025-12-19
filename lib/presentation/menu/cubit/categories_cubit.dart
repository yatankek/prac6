import 'package:bloc/bloc.dart';
import 'package:prac6/presentation/menu/cubit/categories_state.dart';
import 'package:prac6/domain/usecases/get_all_dishes.dart';

/// Cubit для управления категориями
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllDishes _getAllDishes;

  CategoriesCubit({
    required GetAllDishes getAllDishes,
  })  : _getAllDishes = getAllDishes,
        super(const CategoriesState());

  /// Загрузить категории
  Future<void> loadCategories() async {
    emit(state.copyWith(isLoading: true));

    try {
      final dishes = await _getAllDishes();
      final categories = ['Все', 'Паста', 'Пицца', 'Гриль', 'Салаты', 'Десерты'];

      emit(CategoriesState(
        dishes: dishes,
        filteredDishes: dishes,
        categories: categories,
        selectedCategory: 'Все',
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Выбрать категорию
  void selectCategory(String category) {
    final filteredDishes = category == 'Все'
        ? state.dishes
        : state.dishes.where((dish) => dish.name.contains(category)).toList();

    emit(state.copyWith(
      selectedCategory: category,
      filteredDishes: filteredDishes,
    ));
  }
}

