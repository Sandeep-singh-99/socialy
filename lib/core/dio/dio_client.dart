import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import '../constants/api.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: {"Content-Type": "application/json"},
  ),
);

void setupInterceptors() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getAccessToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshed = await _refreshToken();

          if (refreshed) {
            final newToken = await TokenStorage.getAccessToken();
            error.requestOptions.headers["Authorization"] = "Bearer $newToken";

            return handler.resolve(await dio.fetch(error.requestOptions));
          }
        }
        handler.next(error);
      },
    ),
  );
}

Future<bool> _refreshToken() async {
  try {
    final refresh = await TokenStorage.getRefreshToken();
    if (refresh == null) return false;

    final res = await dio.post(
      "/api/auth/refresh-token",
      data: {"refreshToken": refresh},
    );

    await TokenStorage.saveTokens(
      accessToken: res.data["accessToken"],
      refreshToken: res.data["refreshToken"],
    );

    return true;
  } catch (_) {
    return false;
  }
}
