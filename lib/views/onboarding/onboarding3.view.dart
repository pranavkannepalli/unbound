import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/textInput.dart";
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

    print(userData?.interests);

    if (userData?.interests != null && !userDataTried) {
      print("setting state");
      setState(() {
        interests = userData!.interests as List<String>;
        userDataTried = true;
      });
    }

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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text("Bio (250 words)", style: Theme.of(context).textTheme.bodyLarge),
                    TextFormField(
                      initialValue: userData?.bio ?? "",
                      decoration: textInputDecoration.copyWith(hintText: "Tell us about you!"),
                      validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                      onChanged: (val) => bio = val,
                      maxLines: 8,
                      minLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    Text("Interests", style: Theme.of(context).textTheme.bodyLarge),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: interests.length,
                      itemBuilder: (BuildContext context, int index) => TextFormField(
                        initialValue: interests[index],
                        decoration: textInputDecoration.copyWith(
                          hintText: "Ex: Computer Science",
                          /*suffixIcon: TextButton(
                            child: const Icon(Icons.close),
                            onPressed: () {
                              interests.removeAt(index);
                              setState(() => interests=interests);
                            },
                          ),*/
                        ),
                        validator: (val) => val != null && val.isEmpty ? 'No empty interests!.' : null,
                        onChanged: (val) => interests[index] = val,
                      ),
                    ),
                    Row(
                      children: [
                        FilledButton(
                          onPressed: () {
                            interests.add("");
                            setState(() => interests = interests);
                          },
                          style: lightExpand,
                          child: Text(
                            "Add Interest",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: const Color(0xFF4C4C4C),
                                ),
                          ),
                        ),
                        FilledButton(
                          onPressed: () {
                            interests.removeLast();
                            setState(() => interests = interests);
                          },
                          style: lightExpand,
                          child: Text(
                            "Remove Last",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: const Color(0xFF4C4C4C),
                                ),
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
