import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/textInput.dart";
import "package:unbound/service/auth.dart";

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text("Email", style: Theme.of(context).textTheme.bodyLarge),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: "johndoe@example.com"),
                      validator: (val) => val != null && val.isEmpty ? 'Please enter a email' : null,
                      onChanged: (val) => email = val,
                    ),
                    const SizedBox(height: 10.0),
                    Text("Password", style: Theme.of(context).textTheme.bodyLarge),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: "Password"),
                      validator: (val) => val != null && val.length < 6 ? 'Must be 6+ characters long' : null,
                      onChanged: (val) => pw = val,
                      obscureText: true,
                    ),
                    Text(error),
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
