import 'package:prac6/core/models/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> getUserProfile();
}
