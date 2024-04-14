import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";

class Onboarding4 extends StatefulWidget {
  const Onboarding4({super.key});

  @override
  State<Onboarding4> createState() => _Onboarding4State();
}

class _Onboarding4State extends State<Onboarding4> {
  String bio = "";
  List<String> interests = <String>[""];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);
    UserData? userData = Provider.of<UserData?>(context);
    final router = GoRouter.of(context);

    print(interests);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About You",
                style: Theme.of(context).textTheme.titleLarge,
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
            FilledButton(
              style: darkExpand,
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  if (user?.uid != null) {
                    DatabaseService(uid: user!.uid).updateUserData({
                      "bio": bio.isNotEmpty ? bio : userData?.bio ?? "",
                      "interests": interests,
                    });
                    router.go('/onboarding4');
                  }
                }
              },
              child: Text(
                "Continue",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFFFFFFFF),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
