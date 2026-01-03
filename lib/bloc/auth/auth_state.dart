import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCodeSent extends AuthState {
  final String verificationId;
  AuthCodeSent(this.verificationId);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);
}

class AuthUser extends AuthState {
  final User user;

  AuthUser(this.user);
}
