import 'package:prac6/domain/repositories/menu_repository.dart';

class GetCategories {
  final MenuRepository _repository;

  GetCategories(this._repository);

  Future<List<String>> call() async {
    return await _repository.getCategories();
  }
}
