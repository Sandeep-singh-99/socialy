import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialy/core/storage/token_storage.dart';
import 'package:socialy/features/auth/bloc/auth_event.dart';
import 'package:socialy/features/auth/bloc/auth_state.dart';
import 'package:socialy/features/auth/data/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<FirebaseLoginRequested>(_login);
    on<LogoutRequested>(_logout);
  }

  Future<void> _login(
    FirebaseLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await repository.loginWithFirebase(event.firebaseToken);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError("Login Failed"));
    }
  }

  Future<void> _logout(LogoutRequested event, Emitter<AuthState> emit) async {
    await TokenStorage.clear();
    emit(AuthUnauthenticated());
  }
}
