import 'package:socialy/core/storage/token_storage.dart';
import 'package:socialy/features/auth/data/auth_api.dart';
import 'package:socialy/features/auth/data/models/user_model.dart';

class AuthRepository {
  final _api = AuthApi();

  Future<UserModel> loginWithFirebase(String firebaseToken) async {
    final data = await _api.firebaseLogin(firebaseToken);

    await TokenStorage.saveTokens(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
    );

    return UserModel.fromJson(data['user']);
  }
}
