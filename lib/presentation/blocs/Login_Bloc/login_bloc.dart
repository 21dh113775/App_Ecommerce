import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/auth_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginWithGoogle>(_onLoginWithGoogle);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final userCredential = await authService.signInWithEmailPassword(
        event.email,
        event.password,
      );
      if (userCredential != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Đăng nhập không thành công'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final userCredential = await authService.signInWithGoogle();
      if (userCredential != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Đăng nhập Google không thành công'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
