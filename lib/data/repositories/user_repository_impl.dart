import 'package:prac6/core/models/user_profile.dart';
import 'package:prac6/domain/repositories/user_repository.dart';
import 'package:prac6/data/datasources/remote/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserProfile> getUserProfile() async {
    try {
      final userDto = await _remoteDataSource.getUser();
      final name = '${userDto.name.first} ${userDto.name.last}';
      final email = userDto.email;
      final image = userDto.picture.large;
      
      return UserProfile(name: name, email: email, imageUrl: image);
    } catch (e) {
      throw Exception('Ошибка загрузки профиля: $e');
    }
  }
}
