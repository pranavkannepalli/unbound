import "package:date_time_picker/date_time_picker.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  String fname = "";
  String lname = "";
  String bday = DateTime(2007, 2, 26).toString();

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
                "Basic Info",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                              const SizedBox(height: 6),
                              TextFormField(
                                initialValue: userData?.name.split(" ").elementAtOrNull(0) ?? "",
                                decoration: textInputDecoration.copyWith(hintText: "John"),
                                validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                onChanged: (val) => fname = val,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Last Name", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                              const SizedBox(height: 6),
                              TextFormField(
                                  initialValue: userData?.name.split(" ").elementAtOrNull(1) ?? "",
                                  decoration: textInputDecoration.copyWith(hintText: "Doe"),
                                  validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                  onChanged: (val) => lname = val,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text("Date of Birth", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    DateTimePicker(
                      decoration: textInputDecoration,
                      type: DateTimePickerType.date,
                      initialValue: DateTime(2007, 2, 26).toString(),
                      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
                      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
                      initialDate: DateTime(2007, 2, 26),
                      onChanged: (val) => bday = val,
                      validator: (val) => val != null && val.isEmpty ? "Please fill this." : null,
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
                      "name": fname.isNotEmpty && lname.isNotEmpty ? "$fname $lname" : userData?.name ?? "",
                      "bday": bday.isNotEmpty ? bday : userData?.bday ?? "",
                    });
                    router.go('/onboarding2');
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
