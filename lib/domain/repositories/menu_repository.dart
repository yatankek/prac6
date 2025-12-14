import 'package:prac6/core/models/dish.dart';

/// Абстрактный интерфейс репозитория меню
/// Определяет ЧТО должна делать система, но не КАК
abstract class MenuRepository {
  /// Получить все блюда из меню
  Future<List<Dish>> getAllDishes();

  /// Получить блюдо по ID
  Future<Dish> getDishById(String id);

  /// Поиск блюд по запросу
  Future<List<Dish>> searchDishes(String query);
}

