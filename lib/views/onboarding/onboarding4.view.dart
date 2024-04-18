import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/theme.dart";

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    GoRouter router = GoRouter.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "About You",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Welcome to Unbound. Start exploring our app to find anything or anyone you need to achieve your college admission goals.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: white.shade700),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                "Next Steps:",
                style: Theme.of(context).textTheme.displaySmall
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => router.go('/main'),
                style: greyExpand,
                child: Row(
                  children: [
                    Icon(Ionicons.person, color: pink.shade400, size: 18),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        "Create Your Portfolio",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: white.shade800,
                            ),
                      ),
                    ),
                    Icon(Ionicons.chevron_forward, color: white.shade700, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => router.go('/main'),
                style: greyExpand,
                child: Row(
                  children: [
                    Icon(Ionicons.school, color: purple.shade400, size: 18),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        "Create a College List",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: white.shade800,
                            ),
                      ),
                    ),
                    Icon(Ionicons.chevron_forward, color: white.shade700, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => router.go('/main'),
                style: greyExpand,
                child: Row(
                  children: [
                    Icon(Ionicons.people, color: green.shade400, size: 18),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        "Find Students Like You",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: white.shade800,
                            ),
                      ),
                    ),
                    Icon(Ionicons.chevron_forward, color: white.shade700, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => router.go('/main'),
                style: greyExpand,
                child: Row(
                  children: [
                    Icon(Ionicons.briefcase, color: blue.shade600, size: 18),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Text(
                        "Find Internships For You",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: white.shade800,
                            ),
                      ),
                    ),
                    Icon(Ionicons.chevron_forward, color: white.shade700, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () => GoRouter.of(context).go('/main'),
              child: Text(
                "Later",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF4C4C4C),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
