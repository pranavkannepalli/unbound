import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/textInput.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  String school = "";
  String grad = "";
  String state = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);
    UserData? userData = Provider.of<UserData?>(context);
    final router = GoRouter.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Academics",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text("High School", style: Theme.of(context).textTheme.bodyLarge),
                    TextFormField(
                      initialValue: userData?.school ?? "",
                      decoration: textInputDecoration.copyWith(hintText: "Blank High School"),
                      validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                      onChanged: (val) => school = val,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Graduation Year", style: Theme.of(context).textTheme.bodyLarge),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: userData?.grad != -1 ? userData?.grad.toString() ?? "" : "",
                                decoration: textInputDecoration.copyWith(hintText: "2025"),
                                validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                onChanged: (val) => grad = val,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State", style: Theme.of(context).textTheme.bodyLarge),
                              TextFormField(
                                initialValue: userData?.state ?? "",
                                decoration: textInputDecoration.copyWith(hintText: "WA"),
                                validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                onChanged: (val) => state = val,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
            FilledButton(
              style: darkExpand,
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  if (user?.uid != null) {
                    DatabaseService(uid: user!.uid).updateUserData({
                      "grad": grad.isNotEmpty ? int.parse(grad) : userData?.grad ?? 0,
                      "school": school.isNotEmpty ? school : userData?.school ?? "",
                      "state": state.isNotEmpty ? state : userData?.state ?? "",
                    });
                    router.go('/onboarding3');
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
