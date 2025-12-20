import 'package:dio/dio.dart';
import 'package:prac6/data/datasources/remote/api/api_config.dart';
import 'package:prac6/data/datasources/remote/models/user_dto.dart';

abstract class UserRemoteDataSource {
  Future<UserDto> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSourceImpl(this._dio);

  @override
  Future<UserDto> getUser() async {
    final response = await _dio.get(
      ApiConfig.randomUserBaseUrl,
      queryParameters: {'results': 1},
    );

    final results = response.data['results'] as List;
    if (results.isEmpty) {
      throw Exception('Пользователь не найден');
    }

    return UserDto.fromJson(results.first as Map<String, dynamic>);
  }
}
