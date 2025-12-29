import 'package:go_router/go_router.dart';
import 'package:socialy/page/login.dart';
import 'package:socialy/page/otp_screen.dart';
import 'package:socialy/page/splash_screen.dart';
import 'package:socialy/page/welcome_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: '/otp', builder: (context, state) => const OtpScreen()),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
  ],
);
