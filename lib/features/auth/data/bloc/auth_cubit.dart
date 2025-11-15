import 'package:bloc/bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void login(String username, String password) {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    Future.delayed(const Duration(seconds: 2), () {
      if (username.isNotEmpty && password.isNotEmpty) {
        emit(AuthState(isAuthenticated: true, isLoading: false));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Неверные логин или пароль',
        ));
      }
    });
  }

  void logout() {
    emit(const AuthState(isAuthenticated: false, isLoading: false));
  }
}