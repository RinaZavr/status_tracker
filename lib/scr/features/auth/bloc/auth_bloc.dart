import 'package:api/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthGetMeEvent>(_onGetMe);
    on<AuthLogoutEvent>(_onLogout);
  }

  final AuthService authService = AuthService();

  bool isAuthorized() => state is AuthAuthenticated;

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      await authService.login(login: event.login, password: event.password);

      emit(AuthAuthenticated());
    } catch (_) {
      emit(AuthNotAuthenticated());

      Utils.showSnackBar(
        title: 'Ошибка входа',
        message: 'Не удалось выполнить вход',
        isError: true,
      );
    }
  }

  Future<void> _onRegister(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authService.register(
        name: event.name,
        surname: event.surname,
        email: event.email,
        login: event.login,
        password: event.password,
        secretKey: event.secretKey,
      );

      emit(AuthAuthenticated());
    } catch (_) {
      emit(AuthNotAuthenticated());

      Utils.showSnackBar(
        title: 'Ошибка входа',
        message: 'Не удалось выполнить регистрацию',
        isError: true,
      );
    }
  }

  Future<void> _onGetMe(AuthGetMeEvent event, Emitter<AuthState> emit) async {
    try {
      await authService.me();

      emit(AuthAuthenticated());
    } catch (_) {
      emit(AuthNotAuthenticated());
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await authService.logout();

      emit(AuthNotAuthenticated());
    } catch (_) {
      emit(AuthAuthenticated());
    }
  }
}
