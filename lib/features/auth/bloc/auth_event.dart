abstract class AuthEvent {}

class FirebaseLoginRequested extends AuthEvent {
  final String firebaseToken;

  FirebaseLoginRequested(this.firebaseToken);
}

class LogoutRequested extends AuthEvent {}
