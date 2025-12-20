import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';
import 'package:prac6/data/datasources/remote/menu_remote_data_source.dart';

/// Реализация репозитория меню
/// Теперь использует удаленный источник данных (Remote Data Source)
class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource _remoteDataSource;

  MenuRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Dish>> getAllDishes() async {
    try {
      // Default query to get some items
      return await _remoteDataSource.searchDishes('Chicken');
    } catch (e) {
      throw Exception('Ошибка при получении блюд: $e');
    }
  }

  @override
  Future<Dish> getDishById(String id) async {
    try {
      return await _remoteDataSource.getDishById(id);
    } catch (e) {
      throw Exception('Ошибка при получении блюда: $e');
    }
  }

  @override
  Future<List<Dish>> searchDishes(String query) async {
    try {
      if (query.isEmpty) {
        return await getAllDishes();
      }
      return await _remoteDataSource.searchDishes(query);
    } catch (e) {
      throw Exception('Ошибка при поиске блюд: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      return await _remoteDataSource.getCategories();
    } catch (e) {
      throw Exception('Ошибка загрузки категорий: $e');
    }
  }

  @override
  Future<List<Dish>> getDishesByCategory(String category) async {
    try {
      return await _remoteDataSource.getDishesByCategory(category);
    } catch (e) {
      throw Exception('Ошибка загрузки блюд категории: $e');
    }
  }
}
