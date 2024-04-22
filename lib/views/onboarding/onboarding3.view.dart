import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  String bio = "";
  List<String> interests = <String>[""];
  bool userDataTried = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);
    UserData? userData = Provider.of<UserData?>(context);
    final router = GoRouter.of(context);

    if (userData?.interests != null && !userDataTried) {
      print("setting state");
      setState(() {
        interests = userData!.interests as List<String>;
        userDataTried = true;
      });
    }

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
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12.0),
                    Text("Bio (250 words)", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      initialValue: userData?.bio ?? "",
                      decoration: textInputDecoration.copyWith(hintText: "Tell us about yourself"),
                      validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                      onChanged: (val) => bio = val,
                      maxLines: 8,
                      minLines: 2,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                    Text("Interests (Add 3)", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: interests.length,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                        itemBuilder: (BuildContext context, int index) => InterestTextField(
                            key: UniqueKey(),
                            initialValue: interests[index],
                            onChanged: (v) {
                              interests[index] = v;
                            },
                            remove: () {
                              setState(() {
                                interests.removeAt(index);
                              });
                            })),
                    const SizedBox(height: 12),
                    if (interests.length < 3)
                      FilledButton(
                        onPressed: () {
                          if (interests.length < 3) {
                            interests.add("");
                            setState(() => {});
                          }
                        },
                        style: lightExpand,
                        child: Text(
                          "Add Interest",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: const Color(0xFF4C4C4C),
                              ),
                        ),
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

class InterestTextField extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;
  final void Function() remove;
  const InterestTextField({super.key, this.initialValue, required this.onChanged, required this.remove});

  @override
  State<InterestTextField> createState() => _InterestTextFieldState();
}

class _InterestTextFieldState extends State<InterestTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialValue ?? "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: textInputDecoration.copyWith(
          hintText: "Ex: Computer Science",
          suffixIcon: IconButton(onPressed: widget.remove, icon: Icon(Ionicons.close, size: 16, color: white.shade700))),
      style: Theme.of(context).textTheme.bodyLarge,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return "No empty interests!";
        return null;
      },
    );
  }
}
