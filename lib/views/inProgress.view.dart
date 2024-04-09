import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: TextButton(
            child: const Text("Go home!"),
            onPressed: () => GoRouter.of(context).go('/splash'),
          ),
        ),
      ),
    );
  }
}
