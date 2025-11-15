import 'package:bloc/bloc.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/features/menu/data/bloc/menu/menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository _menuRepository;

  MenuCubit()
      : _menuRepository = getIt<MenuRepository>(),
        super(const MenuState());

  void loadMenu() {
    emit(state.copyWith(isLoading: true));

    final dishes = _menuRepository.getAllDishes();

    emit(MenuState(dishes: dishes, isLoading: false));
  }

  void searchDishes(String query) {
    final allDishes = _menuRepository.getAllDishes();
    final filteredDishes = query.isEmpty
        ? allDishes
        : allDishes.where((dish) =>
    dish.name.toLowerCase().contains(query.toLowerCase()) ||
        dish.description.toLowerCase().contains(query.toLowerCase())
    ).toList();

    emit(MenuState(
      dishes: allDishes,
      filteredDishes: filteredDishes,
      searchQuery: query,
      isLoading: false,
    ));
  }
}