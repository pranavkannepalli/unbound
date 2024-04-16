import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/buttons.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/auth.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserData? userData = Provider.of<UserData?>(context);

    if (userData != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(userData.name ?? ""),
              TextButton(
                child: const Text("Go home!"),
                onPressed: () async {
                  await AuthService().signOut();
                  GoRouter.of(context).go('/landing');
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                style: textExpand,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Ionicons.newspaper,
                      size: 20.0,
                      color: Color(0xFF727272),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Feed",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12.0, color: const Color(0xFF727272)),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
    }

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
