import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unbound/firebase_options.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/auth.dart';
import 'package:unbound/views/authentication/signin.view.dart';
import 'package:unbound/views/authentication/landing.view.dart';
import 'package:unbound/views/authentication/signup.view.dart';
import 'package:unbound/views/inProgress.view.dart';
import 'package:unbound/views/onboarding/onboarding1.view.dart';
import 'package:unbound/views/onboarding/onboarding2.view.dart';
import 'package:unbound/views/onboarding/onboarding3.view.dart';
import 'package:unbound/views/onboarding/onboarding4.view.dart';
import 'package:unbound/views/splash.view.dart';
import 'package:unbound/views/userDataProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Unbound());
}

bool loggedIn(BuildContext context) {
  final user = Provider.of<AuthUser?>(context, listen: false);
  print("logged in:${user != null}");
  return user != null;
}

String? loggedInRedirect(BuildContext context) {
  if (loggedIn(context)) {
    return "/onboarding1";
  }
  return null;
}

final _router = GoRouter(
  redirectLimit: 10,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: "/splash",
      builder: (context, state) => const Splash(),
    ),
    GoRoute(
      path: "/landing",
      builder: (context, state) => const LandingScreen(),
      redirect: (context, state) => loggedInRedirect(context),
    ),
    GoRoute(
      path: "/signUp",
      builder: (context, state) => const SignUp(),
      redirect: (context, state) => loggedInRedirect(context),
    ),
    GoRoute(
      path: "/signIn",
      builder: (context, state) => const SignIn(),
      redirect: (context, state) => loggedInRedirect(context),
    ),
    GoRoute(
      path: "/onboarding1",
      builder: (context, state) => const Onboarding1(),
      redirect: (context, state) {
        AuthUser? user = Provider.of<AuthUser?>(context, listen: false);
        UserData? userData = Provider.of<UserData?>(context, listen: false);

        if (user?.uid == null) {
          return '/splash';
        }
        if (userData?.name != null && userData?.name != "" && userData?.bday != null && userData?.bday != "") {
          return '/onboarding2';
        }
        return null;
      },
    ),
    GoRoute(
      path: "/onboarding2",
      builder: (context, state) => const Onboarding2(),
      redirect: (context, state) {
        AuthUser? user = Provider.of<AuthUser?>(context, listen: false);
        UserData? userData = Provider.of<UserData?>(context, listen: false);

        if (user?.uid == null) {
          return '/splash';
        }

        if (userData?.school != null &&
            userData?.school != "" &&
            userData?.state != null &&
            userData?.state != "" &&
            userData?.grad != 0) {
          return '/onboarding3';
        }
        return null;
      },
    ),
    GoRoute(
      path: "/onboarding3",
      builder: (context, state) => const Onboarding3(),
      redirect: (context, state) {
        AuthUser? user = Provider.of<AuthUser?>(context, listen: false);
        UserData? userData = Provider.of<UserData?>(context, listen: false);

        if (user?.uid == null) {
          return '/splash';
        }

        if (userData?.bio != null && userData?.bio != "" && userData?.interests != null && userData!.interests!.isNotEmpty) {
          return '/feed';
        }
        return null;
      },
    ),
    GoRoute(
      path: "/onboarding4",
      builder: (context, state) => const Onboarding4(),
    ),
    GoRoute(
      path: "/feed",
      builder: (context, state) => const InProgressScreen(),
    ),
  ],
);

class Unbound extends StatelessWidget {
  const Unbound({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      initialData: null,
      child: UserProvider(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: unboundTheme,
        ),
      ),
    );
  }
}
