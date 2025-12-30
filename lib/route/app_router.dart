import 'package:go_router/go_router.dart';
import 'package:socialy/page/chat_page.dart';
import 'package:socialy/page/home_screen.dart';
import 'package:socialy/page/login.dart';
import 'package:socialy/page/otp_screen.dart';
import 'package:socialy/page/splash_screen.dart';
import 'package:socialy/page/user_details_upload.dart';
import 'package:socialy/page/welcome_screen.dart';

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
        final extras = state.extra as Map<String, dynamic>;
        return OtpScreen(
          verificationId: extras['verificationId'],
          phoneNumber: extras['phoneNumber'],
        );
      },
    ),
    GoRoute(
      path: '/user_details',
      builder: (context, state) => const UserDetailsUpload(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
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
