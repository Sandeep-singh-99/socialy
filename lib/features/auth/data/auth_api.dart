import 'package:socialy/core/dio/dio_client.dart';

class AuthApi {
  Future<Map<String, dynamic>> firebaseLogin(String firebaseToken) async {
    final res = await dio.post(
      "/api/auth/firebase-login",
      data: {"firebaseToken": firebaseToken},
    );
    return res.data;
  }
}
