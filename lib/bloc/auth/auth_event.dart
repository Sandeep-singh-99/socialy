import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent(this.verificationId, this.otp);

  @override
  List<Object?> get props => [verificationId, otp];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class GetCurrentUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}