import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Centered Logo
          Center(
            child: Image.asset(
              'assets/ic.png',
              width: 150, // Increased size
              height: 150,
            ),
          ),
          // Footer
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'from',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Optional: Icon(Icons.flash_on, color: Color(0xFF25D366), size: 20), // Placeholder for logo icon if desired
                    // SizedBox(width: 5),
                    Text(
                      'Socialy',
                      style: TextStyle(
                        color: Color(
                          0xFF25D366,
                        ), // WhatsApp brighter green for footer often used
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0, // Spced out like "META"
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
