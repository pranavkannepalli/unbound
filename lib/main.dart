import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unbound/firebase_options.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/improve.model.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/auth.dart';
import 'package:unbound/views/authentication/signin.view.dart';
import 'package:unbound/views/authentication/landing.view.dart';
import 'package:unbound/views/authentication/signup.view.dart';
import 'package:unbound/views/college/profile.view.dart';
import 'package:unbound/views/company/profile.view.dart';
import 'package:unbound/views/feed/createPost.view.dart';
import 'package:unbound/views/improve/viewExercise.view.dart';
import 'package:unbound/views/main.view.dart';
import 'package:unbound/views/onboarding/onboarding1.view.dart';
import 'package:unbound/views/onboarding/onboarding2.view.dart';
import 'package:unbound/views/onboarding/onboarding3.view.dart';
import 'package:unbound/views/onboarding/onboarding4.view.dart';
import 'package:unbound/views/search/search.view.dart';
import 'package:unbound/views/splash.view.dart';
import 'package:unbound/views/user/profile.view.dart';
import 'package:unbound/views/userDataProvider.dart';
import 'package:unbound/views/userProfile/add/add_course.view.dart';
import 'package:unbound/views/userProfile/add/add_test.view.dart';
import 'package:unbound/views/userProfile/edit/edit_basic_info.view.dart';
import 'package:unbound/views/userProfile/edit/edit_course.view.dart';
import 'package:unbound/views/userProfile/edit/edit_test.view.dart';
import 'package:unbound/views/viewImages.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Unbound());
}

bool loggedIn(BuildContext context) {
  final user = Provider.of<AuthUser?>(context, listen: false);
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

        if (userData?.bio != null && userData?.bio != "" && userData?.interests != null && userData!.interests.isNotEmpty) {
          return '/';
        }
        return null;
      },
    ),
    GoRoute(
      path: "/onboarding4",
      builder: (context, state) => const Onboarding4(),
    ),
    GoRoute(
        path: "/",
        builder: (context, state) => const MainScreen(),
        redirect: (context, state) {
          if (!loggedIn(context)) {
            return "/landing";
          }
          return null;
        }),
    GoRoute(
      path: "/createPost",
      builder: (context, state) => const CreatePost(),
    ),
    GoRoute(
      path: "/search",
      builder: (context, state) => Search(initialQuery: state.extra! as String),
    ),
    GoRoute(
      path: "/user",
      builder: (context, state) => UserProfile(uid: state.extra! as String),
    ),
    GoRoute(
      path: "/gallery",
      pageBuilder: (context, state) => CustomTransitionPage(
        fullscreenDialog: true,
        opaque: false,
        child: ImageGallery(images: state.extra as List<String>),
        transitionsBuilder: (_, __, ___, child) => child,
      ),
    ),
    GoRoute(path: "/company", builder: (context, state) => CompanyProfile(uid: state.extra! as String)),
    GoRoute(path: "/college", builder: (context, state) => CollegeProfile(uid: state.extra! as String)),
    GoRoute(
      path: "/addTest",
      builder: (context, state) => const AddTest(),
    ),
    GoRoute(
      path: "/editTest",
      builder: (context, state) => EditTest(old: state.extra! as TestScore),
    ),
    GoRoute(
      path: "/addCourse",
      builder: (context, state) => const AddCourse(),
    ),
    GoRoute(
      path: "/editCourse",
      builder: (context, state) => EditCourse(old: state.extra! as Course),
    ),
    GoRoute(
      path: "/editBasicInfo",
      builder: (context, state) => EditBasicInfo(old: state.extra! as UserData),
    ),
    GoRoute(path: "/exercise", builder: (context, state) => ViewExercise(exercise: state.extra! as Exercise))
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
