import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/service/auth.dart";

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool showPw = false;
  String email = "";
  String pw = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12.0),
                    Text("Email", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: textInputDecoration.copyWith(hintText: "johndoe@example.com"),
                      validator: (val) => val != null && val.isEmpty ? 'Please enter a email' : null,
                      onChanged: (val) => email = val,
                    ),
                    const SizedBox(height: 12.0),
                    Text("Password", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: textInputDecoration.copyWith(
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                    showPw = !showPw;
                                  }),
                              icon: Icon(
                                showPw ? Ionicons.eye_off : Ionicons.eye,
                                size: 16,
                              ))),
                      validator: (val) => val != null && val.length < 6 ? 'Must be 6+ characters long' : null,
                      onChanged: (val) => pw = val,
                      obscureText: !showPw,
                    ),
                    Text(error),
                  ],
                ),
              ),
              Row(children: [
                Expanded(child: Divider(thickness: 1, color: white.shade600)),
                const SizedBox(width: 16),
                Text("OR", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: white.shade600)),
                const SizedBox(width: 16),
                Expanded(child: Divider(thickness: 1, color: white.shade600)),
              ]),
              const SizedBox(height: 16.0),
              TextButton(
                  onPressed: () async {
                    dynamic result = await AuthService().signInWithGoogle();
                    if (result == null) {
                      setState(() {
                        error = 'Please check if you have entered a valid email and password.';
                      });
                    } else if (result.runtimeType == String) {
                      setState(() {
                        error = 'Please check if you have entered a valid email and password.';
                      });
                    } else {
                      GoRouter.of(context).go("/onboarding1");
                      print(result.uid);
                    }
                  },
                  style: lightExpand,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Ionicons.logo_google, size: 16, color: white.shade900),
                      const SizedBox(width: 12),
                      Text("Google", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: white.shade900))
                    ],
                  )),
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
              onPressed: () => GoRouter.of(context).go('/signUp'),
              child: Text(
                "Need an Account? Sign Up",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF4C4C4C),
                    ),
              ),
            ),
            FilledButton(
              style: darkExpand,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result = await _auth.signIn(email, pw);
                  if (result == null) {
                    setState(() {
                      error = 'Please check if you have entered a valid email';
                    });
                  } else if (result.runtimeType == String) {
                    setState(() {
                      error = result;
                    });
                  } else {
                    GoRouter.of(context).go("/onboarding1");
                    print(result.uid);
                  }
                }
              },
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
    );
  }
}
