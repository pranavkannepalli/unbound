# Unbound

An app for students to create a share their academic achievements and find college tips. This app allows students to showcase their academic achievements, athletic participation, performing arts experience, clubs memberships, community service hours, and coursework, while also enabling them to find other students with similar intersts

## Code Description

This project is a completed Flutter project that follows the MVVM architecture. What this means is the product is divided into seperate chunks:

-   Models - Manages data and rules about how it should be handled
-   Views - What the user sees and interacts with
-   ViewModels - Transport data from the Model to the Views, and handles deletion and addition of data.
-   Repositories - Handle data fetching from the backend
-   Services - specific functions for

For a new user, it's recommended to study this architecture being touching this codebase, although each file is marked with its type (.view, .widget, .model.etc).

## Necessary Tools:

Necessary:

-   Git - To Clone the Repository (https://git-scm.com/downloads)
-   android-studio/xcode/physical device - to run an emulator and test code on (https://developer.android.com/studio/)
-   Flutter SDK - necessary for flutter projects to be recognized, built, and run (https://docs.flutter.dev/get-started/install)
-   Code editor (we used VS code)

Also recommended:

-   VS Code
-   VS Code Extensions such as the Flutter Extension or Awesome Flutter Snippets
-   Github Desktop

## Get Started

### Cloning

To get started, first attain access and clone from GitHub. It is recommended that you utilize the in-built vscode functions or GithubDesktop to do this, although you can also do it using the GithubCLI.

### Downloading packages

Make sure that pubspec.yaml is there and the necessary packages above have been installed. Then run the following command to pull all the packages locally: `flutter pub get`

### Start Coding

This varies based on your code editor, but if you are using VS code, there is a button at the bottom that allows you to to choose what emulator you want to use. After that, use the debug menu to build the app and push it to the emulator. Finally, you are good to go!

## Packages Used

Below is a list of packages used in this project with versions:

-   cupertino_icons: ^1.0.6
-   firebase_core: ^2.28.0
-   cloud_firestore: ^4.16.0
-   firebase_database: ^10.5.0
-   firebase_auth: ^4.19.0
-   google_fonts: ^6.2.1
-   go_router: ^13.2.3
-   provider: ^6.1.2
-   date_time_picker: ^2.1.0
-   flutter_spinkit: ^5.2.1
-   flutter_hooks: ^0.20.5
-   google_sign_in: ^6.2.1
-   ionicons: ^0.2.2
-   dotted_border: ^2.1.0
-   image_picker: ^1.1.0
-   firebase_storage: ^11.7.2
-   share_plus: ^9.0.0
-   http: ^1.2.1
-   social_share: ^2.3.1
-   path_provider: ^2.1.3
-   instagram_share_plus: ^0.1.0
-   screenshot: ^2.3.0

## Copyright

We assure that all work in this project is our own. We did not utilize any previously existing framework to build this, instead building it from scratch.
