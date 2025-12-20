import 'package:bloc/bloc.dart';
import 'package:prac6/domain/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit(this._userRepository) : super(const ProfileState());

  Future<void> loadUserData() async {
    emit(state.copyWith(isLoading: true));

    try {
      final user = await _userRepository.getUserProfile();
      emit(state.copyWith(
        userName: user.name,
        userEmail: user.email,
        isLoading: false,
      ));
    } catch (e) {
      // For now, just stop loading. In real app, show error.
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateProfile(String name, String email) {
    emit(state.copyWith(
      userName: name,
      userEmail: email,
      isLoading: false,
    ));
  }

  void logout() {
    emit(const ProfileState(
      userName: '',
      userEmail: '',
      isLoading: false,
    ));
  }
}
