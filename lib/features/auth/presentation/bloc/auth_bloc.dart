import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialy/features/auth/data/auth_repository.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthPhoneSubmitted extends AuthEvent {
  final String phoneNumber;

  const AuthPhoneSubmitted(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthOtpSubmitted extends AuthEvent {
  final String otpCode;
  final String verificationId;

  const AuthOtpSubmitted({required this.otpCode, required this.verificationId});

  @override
  List<Object?> get props => [otpCode, verificationId];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthVerificationFailed extends AuthEvent {
  final String message;

  const AuthVerificationFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthCodeSentEvent extends AuthEvent {
  final String verificationId;
  final int? resendToken;

  const AuthCodeSentEvent({required this.verificationId, this.resendToken});

  @override
  List<Object?> get props => [verificationId, resendToken];
}

class AuthCredentialAutoRetrieved extends AuthEvent {
  final PhoneAuthCredential credential;

  const AuthCredentialAutoRetrieved(this.credential);

  @override
  List<Object?> get props => [credential];
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCodeSent extends AuthState {
  final String verificationId;
  final int? resendToken;

  const AuthCodeSent({required this.verificationId, this.resendToken});

  @override
  List<Object?> get props => [verificationId, resendToken];
}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthPhoneSubmitted>(_onAuthPhoneSubmitted);
    on<AuthOtpSubmitted>(_onAuthOtpSubmitted);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthVerificationFailed>(_onAuthVerificationFailed);
    on<AuthCodeSentEvent>(_onAuthCodeSentEvent);
    on<AuthCredentialAutoRetrieved>(_onAuthCredentialAutoRetrieved);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = _authRepository.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onAuthPhoneSubmitted(
    AuthPhoneSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      print('AuthBloc: Verifying phone number ${event.phoneNumber}');
      await _authRepository.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          print('AuthBloc: verificationCompleted triggered');
          add(AuthCredentialAutoRetrieved(credential));
        },
        verificationFailed: (FirebaseAuthException e) {
          print('AuthBloc: verificationFailed: ${e.code} - ${e.message}');
          add(AuthVerificationFailed(e.message ?? 'Verification Failed'));
        },
        codeSent: (String verificationId, int? resendToken) {
          print('AuthBloc: codeSent. VerificationId: $verificationId');
          add(
            AuthCodeSentEvent(
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print(
            'AuthBloc: codeAutoRetrievalTimeout. VerificationId: $verificationId',
          );
        },
      );
    } catch (e) {
      print('AuthBloc: _onAuthPhoneSubmitted exception: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthVerificationFailed(
    AuthVerificationFailed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthError(event.message));
  }

  Future<void> _onAuthCodeSentEvent(
    AuthCodeSentEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      AuthCodeSent(
        verificationId: event.verificationId,
        resendToken: event.resendToken,
      ),
    );
  }

  Future<void> _onAuthCredentialAutoRetrieved(
    AuthCredentialAutoRetrieved event,
    Emitter<AuthState> emit,
  ) async {
    // Treat as if the user entered the OTP (or just sign in directly)
    // Sending to OTP submitted flow or handling directly
    add(
      AuthOtpSubmitted(
        otpCode: event.credential.smsCode ?? '',
        verificationId: 'AUTO',
      ),
    );
    // We could also sign in directly here if we wanted to bypass the specific OTP logic
    // but reusing AuthOtpSubmitted is fine if we want that flow.
    // HOWEVER, AuthOtpSubmitted expects a verificationId which we might not have if it's instant?
    // Actually, let's just do the sign in here to be safe and clean.

    try {
      await _authRepository.signInWithCredential(event.credential);
      emit(AuthAuthenticated(_authRepository.currentUser!));
      print('AuthBloc: Auto-sign-in successful');
    } catch (e) {
      print('AuthBloc: Auto-sign-in failed: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthOtpSubmitted(
    AuthOtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );

      // Sign the user in (or link) with the credential
      await _authRepository.signInWithCredential(credential);

      final user = _authRepository.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthError("User not found after sign in"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
    emit(AuthInitial());
  }
}
