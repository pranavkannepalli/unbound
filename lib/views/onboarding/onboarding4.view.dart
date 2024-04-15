import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:unbound/common/buttons.dart";

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    GoRouter _router = GoRouter.of(context);

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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Welcome to Unbound. Start exploring our app to find anything or anyone you need to achieve your college admission goals.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Next Steps:",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20.0,
                    ),
              ),
              FilledButton(
                onPressed: () => _router.go('/feed'),
                style: greyExpand,
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Color(0xFFAA6685)),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Text(
                        "Create Your Portfolio",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: const Color(0xFF4C4C4C),
                            ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF727272)),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => _router.go('/feed'),
                style: greyExpand,
                child: Row(
                  children: [
                    const Icon(Icons.school, color: Color(0xFF9881A6)),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Text(
                        "Create a College List",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: const Color(0xFF4C4C4C),
                            ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF727272)),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => _router.go('/feed'),
                style: greyExpand,
                child: Row(
                  children: [
                    const Icon(Icons.people, color: Color(0xFF8BA394)),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Text(
                        "Find Students Like You",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: const Color(0xFF4C4C4C),
                            ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF727272)),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => _router.go('/feed'),
                style: greyExpand,
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.briefcase_fill, color: Color(0xFF7194A6)),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Text(
                        "Find Internships For You",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: const Color(0xFF4C4C4C),
                            ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF727272)),
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
              onPressed: () => GoRouter.of(context).go('/feed'),
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
