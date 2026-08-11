# Unbound

A mobile app where students showcase academic achievements and pick up college tips.

**🏆 3rd place, Software Development — TSA Nationals**

## What it is

Unbound is a Flutter app built on an MVVM architecture. Students build a profile, post their coursework, test scores, and achievements to a social feed, search for other users, and browse improvement tips geared toward college prep. Profiles for colleges and companies surface information relevant to higher-education and career decisions. Authentication, profiles, and posts are backed by Firebase (Auth, Firestore, Storage).

## Run it

Requires the Flutter SDK (Dart `>=3.3.3 <4.0.0`) and a configured Firebase project.

```bash
flutter pub get
flutter run
```

Build a release binary:

```bash
flutter build apk        # Android
flutter build ios        # iOS
```

## Stack

Flutter · Dart · MVVM (`model` / `service` / `views`) · Firebase Auth, Firestore, Storage · `provider` for state · `go_router` for navigation · `google_sign_in`.
