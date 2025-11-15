import 'package:bloc/bloc.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/features/menu/data/bloc/categories/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final MenuRepository _menuRepository;

  CategoriesCubit()
      : _menuRepository = getIt<MenuRepository>(),
        super(const CategoriesState());

  void loadCategories() {
    emit(state.copyWith(isLoading: true));

    final dishes = _menuRepository.getAllDishes();
    final categories = ['Все', 'Паста', 'Пицца', 'Гриль', 'Салаты', 'Десерты'];

    emit(CategoriesState(
      dishes: dishes,
      categories: categories,
      selectedCategory: 'Все',
      isLoading: false,
    ));
  }

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