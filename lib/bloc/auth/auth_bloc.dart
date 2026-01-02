import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialy/bloc/auth/auth_event.dart';
import 'package:socialy/bloc/auth/auth_state.dart';
import 'package:socialy/services/firebase_auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthEvent, AuthState>(
      (event, emit) {
        if (event is SendOtpEvent) {
          emit(AuthLoading());
          _authService.verifyPhoneNumber(
            phone: event.phoneNumber,
            codeSent: (verificationId) {
              emit(AuthSuccess(user: _authService.getCurrentUser()!));
            },
            onError: (error) {
              emit(AuthError(error));
            },
          );
        }
      },
    );
  }
}
