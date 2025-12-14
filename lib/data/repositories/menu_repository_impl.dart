import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';
import 'package:prac6/data/datasources/menu_local_data_source.dart';
import 'package:prac6/data/mappers/dish_mapper.dart';

/// Реализация репозитория меню
/// Координирует работу Data Sources и использует Mappers для преобразования данных
class MenuRepositoryImpl implements MenuRepository {
  final MenuLocalDataSource _localDataSource;

  MenuRepositoryImpl(this._localDataSource);

  @override
  Future<List<Dish>> getAllDishes() async {
    try {
      final dtos = await _localDataSource.getAllDishes();
      return DishMapper.toDomainList(dtos);
    } catch (e) {
      throw Exception('Ошибка при получении блюд: $e');
    }
  }

  @override
  Future<Dish> getDishById(String id) async {
    try {
      final dto = await _localDataSource.getDishById(id);
      return DishMapper.toDomain(dto);
    } catch (e) {
      throw Exception('Ошибка при получении блюда: $e');
    }
  }

  @override
  Future<List<Dish>> searchDishes(String query) async {
    try {
      final allDishes = await getAllDishes();
      if (query.isEmpty) {
        return allDishes;
      }
      final lowerQuery = query.toLowerCase();
      return allDishes.where((dish) {
        return dish.name.toLowerCase().contains(lowerQuery) ||
            dish.description.toLowerCase().contains(lowerQuery);
      }).toList();
    } catch (e) {
      throw Exception('Ошибка при поиске блюд: $e');
    }
  }
}

