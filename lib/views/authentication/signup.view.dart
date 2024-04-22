import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/service/auth.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool showPw = false;
  String email = "";
  String pw = "";
  String cpw = "";
  String error = "";
  Map<String, bool> validations = <String, bool>{
    "length": false,
    "nums": false,
    "uppercase": false,
    "lowercase": false,
    "matching": false,
  };


  bool isLongEnough() {
    return pw.trim().length >= 8;
  }

  bool hasNum() {
    RegExp numReg = RegExp(r".*[0-9].*");
    return numReg.hasMatch(pw.trim());
  }

  bool hasUpperCase() {
    RegExp upperReg = RegExp(r".*[A-Z].*");
    return upperReg.hasMatch(pw.trim());
  }

  bool hasLowerCase() {
    RegExp lowerReg = RegExp(r".*[a-z].*");
    return lowerReg.hasMatch(pw.trim());
  }

  bool goodPassword() {
    return pw == cpw && hasUpperCase() && hasLowerCase() && isLongEnough() && hasNum();
  }

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
                "Create an Account",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12.0),
                    Text("Email",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: "johndoe@example.com"),
                      validator: (val) => val != null && val.isEmpty
                          ? 'Please enter a email'
                          : null,
                      onChanged: (val) => email = val,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12.0),
                    Text("Password",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    TextFormField(
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
                      validator: (val) => val != null && val.length < 6
                          ? 'Must be 6+ characters long'
                          : null,
                      onChanged: (val) {
                        pw = val;
                        setState(() {
                          validations["length"] = isLongEnough();
                          validations["nums"] = hasNum();
                          validations["lowercase"] = hasLowerCase();
                          validations["uppercase"] = hasUpperCase();
                          validations["matching"] = cpw == pw;
                        });
                      },
                      obscureText: showPw,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12.0),
                    Text("Confirm Password",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                    showPw = !showPw;
                                  }),
                              icon: Icon(
                                showPw ? Ionicons.eye_off : Ionicons.eye,
                                size: 16,
                              ))),
                      validator: (val) => val != null && val != pw
                          ? 'Passwords do not match.'
                          : null,
                      onChanged: (val) {
                          cpw = val;
                          validations["matching"] = cpw == pw;

                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      obscureText: showPw,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: !validations.values.contains(false) && cpw == pw ? green.shade200: pink.shade200,
                      ),
                      child: Column(children: [
                        Row(children: [
                          Icon((validations["length"] ?? false) ? Ionicons.checkmark: Ionicons.close, size: 14, color: white.shade900),
                          const SizedBox(width: 6),
                          Text("Atleast 8 characters", style: Theme.of(context).textTheme.bodySmall)
                        ]),
                        Row(children: [
                          Icon((validations["nums"] ?? false) ? Ionicons.checkmark: Ionicons.close, size: 14, color: white.shade900),
                          const SizedBox(width: 6),
                          Text("Must have atleast one number", style: Theme.of(context).textTheme.bodySmall)
                        ]),
                        Row(children: [
                          Icon((validations["lowercase"] ?? false) ? Ionicons.checkmark: Ionicons.close, size: 14, color: white.shade900),
                          const SizedBox(width: 6),
                          Text("Must have lowercase letters", style: Theme.of(context).textTheme.bodySmall)
                        ]),
                        Row(children: [
                          Icon((validations["uppercase"] ?? false) ? Ionicons.checkmark: Ionicons.close, size: 14, color: white.shade900),
                          const SizedBox(width: 6),
                          Text("Must have uppercase letters", style: Theme.of(context).textTheme.bodySmall)
                        ]),
                        Row(children: [
                          Icon((cpw == pw) ? Ionicons.checkmark: Ionicons.close, size: 14, color: white.shade900),
                          const SizedBox(width: 6),
                          Text("Passwords must match", style: Theme.of(context).textTheme.bodySmall)
                        ]),
                      ]),
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
              onPressed: () => GoRouter.of(context).go('/signIn'),
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
                  dynamic result =
                      await _auth.registerWithEmailAndPw(email, pw);
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
