import 'package:go_router/go_router.dart';
import 'package:socialy/presentation/screens/login_page.dart';
import 'package:socialy/presentation/screens/otp_page.dart';
import 'package:socialy/presentation/screens/chat_page.dart';
import 'package:socialy/presentation/screens/home_screen.dart';
import 'package:socialy/presentation/screens/splash_screen.dart';
import 'package:socialy/presentation/screens/user_details_upload.dart';
import 'package:socialy/presentation/screens/welcome_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;
        return OtpPage(
          phoneNumber: extras?['phoneNumber'] ?? '',
          verificationId: extras?['verificationId'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/user_details',
      builder: (context, state) => const UserDetailsUpload(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final userName = state.extra as String? ?? 'User';
        return ChatPage(userName: userName);
      },
    ),
  ],
);
