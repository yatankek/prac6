import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';

class GetDishesByCategory {
  final MenuRepository _repository;

  GetDishesByCategory(this._repository);

  Future<List<Dish>> call(String category) async {
    return await _repository.getDishesByCategory(category);
  }
}
