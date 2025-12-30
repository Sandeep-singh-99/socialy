import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialy/firebase_options.dart';
import 'package:socialy/route/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialy/features/auth/bloc/auth_bloc.dart';
import 'package:socialy/features/auth/data/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthRepository())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
