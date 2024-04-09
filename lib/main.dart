import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unbound/firebase_options.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/views/inProgress.view.dart';
import 'package:unbound/views/landing.view.dart';
import 'package:unbound/views/splash.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: "/landing",
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: "/splash",
      builder: (context, state) => const Splash(),
    ),
    GoRoute(
      path: "/signUp",
      builder: (context, state) => const InProgressScreen(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const InProgressScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: unboundTheme,
    );
  }
}
