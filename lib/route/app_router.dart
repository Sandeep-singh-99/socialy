import 'package:go_router/go_router.dart';
import 'package:socialy/page/login.dart';
import 'package:socialy/page/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
  ],
);
