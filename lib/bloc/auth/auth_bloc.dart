import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialy/bloc/auth/auth_event.dart';
import 'package:socialy/bloc/auth/auth_state.dart';
import 'package:socialy/services/firebase_auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      await _authService.verifyPhoneNumber(
        phone: event.phoneNumber,
        codeSent: (verificationId) {
          emit(AuthCodeSent(verificationId));
        },
        onError: (error) {
          emit(AuthError(error));
        },
      );
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.verifyOtp(
          verificationId: event.verificationId,
          otp: event.otp,
        );
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthError("Verification failed"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      await _authService.signOut();
      emit(AuthInitial());
    });

    on<GetCurrentUserEvent>((event, emit) async {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthInitial());
      }
    });
  }
}
