import 'package:bloc/bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void loadUserData() {
    emit(state.copyWith(isLoading: true));

    Future.delayed(const Duration(seconds: 1), () {
      emit(ProfileState(
        userName: 'Иван Иванов',
        userEmail: 'ivan@example.com',
        isLoading: false,
      ));
    });
  }

  void updateProfile(String name, String email) {
    emit(ProfileState(
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
