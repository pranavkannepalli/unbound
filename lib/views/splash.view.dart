import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer t;

  @override
  void initState() {
    super.initState();
    t = Timer(const Duration(seconds: 5), () {
      GoRouter.of(context).go("/landing");
    });
  }

  @override
  void dispose() {
    super.dispose();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/Splash.png"),
      ),
    );
  }
}
