import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unbound/common/buttons.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/LandingGraphic.png", width: 250),
              const SizedBox(height: 24),
              Text("Welcome to Unbound", style: Theme.of(context).textTheme.displayMedium),
              Text("Opportunity, growth, and connections await", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () => GoRouter.of(context).go('/signUp'),
                style: greyExpand,
                child: Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF4C4C4C),
                      ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                style: darkExpand,
                onPressed: () => GoRouter.of(context).go('/signIn'),
                child: Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFFFFFFFF),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
