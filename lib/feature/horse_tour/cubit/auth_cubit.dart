import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String username, String password) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'admin' && password == 'admin') {
      emit(AuthSuccess());
    } else {
      emit(const AuthFailure('Неверный логин или пароль'));
    }
  }
  void logout() {
    emit(AuthInitial());
  }
}
