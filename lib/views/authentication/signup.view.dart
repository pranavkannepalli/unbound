import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/textInput.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/auth.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String pw = "";
  String cpw = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create an Account",
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
                    const SizedBox(height: 10.0),
                    Text("Confirm Password", style: Theme.of(context).textTheme.bodyLarge),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: "Confirm Password"),
                      validator: (val) => val != null && val != pw ? 'Passwords do not match.' : null,
                      onChanged: (val) => cpw = val,
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () => GoRouter.of(context).go('/login'),
              child: Text(
                "Have an Account? Sign In",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF4C4C4C),
                    ),
              ),
            ),
            FilledButton(
              style: darkExpand,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result = await _auth.registerWithEmailAndPw(email, pw);
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
                "Sign Up",
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
