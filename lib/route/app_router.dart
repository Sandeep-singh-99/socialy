import 'package:go_router/go_router.dart';
import 'package:socialy/page/login.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    )
  ]
);