import 'package:bloc/bloc.dart';
import 'package:prac6/presentation/menu/cubit/categories_state.dart';
import 'package:prac6/domain/usecases/get_all_dishes.dart';
import 'package:prac6/domain/usecases/get_categories.dart';
import 'package:prac6/domain/usecases/get_dishes_by_category.dart';

/// Cubit для управления категориями
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllDishes _getAllDishes;
  final GetCategories _getCategories;
  final GetDishesByCategory _getDishesByCategory;

  CategoriesCubit({
    required GetAllDishes getAllDishes,
    required GetCategories getCategories,
    required GetDishesByCategory getDishesByCategory,
  })  : _getAllDishes = getAllDishes,
        _getCategories = getCategories,
        _getDishesByCategory = getDishesByCategory,
        super(const CategoriesState());

  /// Загрузить категории
  Future<void> loadCategories() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Load initial dishes (all or default)
      final dishes = await _getAllDishes();
      
      // Load categories from API
      final categories = await _getCategories();
      
      // Add 'Все' if not present (usually not from API)
      final displayCategories = ['Все', ...categories];

      emit(CategoriesState(
        dishes: dishes,
        filteredDishes: dishes,
        categories: displayCategories,
        selectedCategory: 'Все',
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Выбрать категорию
  Future<void> selectCategory(String category) async {
    emit(state.copyWith(isLoading: true, selectedCategory: category));

    try {
      if (category == 'Все') {
        final dishes = await _getAllDishes();
        emit(state.copyWith(
          filteredDishes: dishes,
          isLoading: false,
        ));
      } else {
        final dishes = await _getDishesByCategory(category);
        emit(state.copyWith(
          filteredDishes: dishes,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
