# Unbound

An app for students to create a share their academic achievements and find college tips. This app allows students to showcase their academic achievements, athletic participation, performing arts experience, clubs memberships, community service hours, and coursework, while also enabling them to find other students with similar interests

## Code Description

This project is a completed Flutter project that follows the MVVM architecture. What this means is the product is divided into separate chunks:

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

## Navigating the App

On landing on the app, you will first be presented with a landing page like below. This will prompt you to either sign in or register a new account.

After that, if the account is incomplete, you will need to provide some basic information through the onboarding pages.

Upon completing those, you will be brought to the feed, where you will be able to view posts from companies, users, and colleges. Hitting the search bar at the top and typing in a query leads to the search results page, where you can find a specific college or user. Hitting any of the links in the bottom app bar takes you to one of the three following pages:

1. View/edit your own profile - where you can view a simplified version of your portfolio and edit relevant sections
2. Improve - where you can view tips for high schoolers to improve their college portfolios
3. Settings - where basic app settings can be edited and the user can log out

Clicking on another user's profile from anywhere will take you to a view of their achievements. Similarly, colleges and companies will show information relevant to high schoolers that will help them make decisions about their higher education and later career.

## Packages Used

Below is a list of packages used in this project with versions and descriptions:

-   cupertino_icons: ^1.0.6 - basic icon package that comes with flutter, used some icons from here (https://pub.dev/packages/cupertino_icons)
-   firebase_core: ^2.28.0 - allows for integration with firebase and initialization of firebase apps with flutterfire (https://pub.dev/packages/firebase_core)
-   cloud_firestore: ^4.16.0 - our main database service, used to hold all data about users, companies, colleges, and posts (https://pub.dev/packages/cloud_firestore)
-   firebase_auth: ^4.19.0 - used to register and authenticate users (https://pub.dev/packages/firebase_auth)
-   google_fonts: ^6.2.1 - used to fetch fonts from google fonts that we use in our theme page (https://pub.dev/packages/google_fonts)
-   go_router: ^13.2.3 - used for routing throughout the app, allows for deep routing and passing objects in between routes easily (https://pub.dev/packages/go_router)
-   provider: ^6.1.2 - used to serve data around the app. providers are created above every other widget for both auth and user data and utilized by child widgets to read that data (https://pub.dev/packages/provider)
-   date_time_picker: ^2.1.0 - used to pick dates, like the user's birthday (https://pub.dev/packages/date_time_picker)
-   flutter_spinkit: ^5.2.1 - used for loading animations while data is being fetched or while the user is being authenticated (https://pub.dev/packages/flutter_spinkit)
-   google_sign_in: ^6.2.1 - used to integrate google sign in into our application alongside firebase_auth (https://pub.dev/packages/google_sign_in)
-   ionicons: ^0.2.2 - other icon package used alongside cupertino_icons, most icons across this app come from here (https://pub.dev/packages/ionicons)
-   dotted_border: ^2.1.0 - used to create box borders of different styles around some widgets (https://pub.dev/packages/dotted_border)
-   image_picker: ^1.1.0 - used to prompt the user to upload an image (https://pub.dev/packages/image_picker)
-   firebase_storage: ^11.7.2 - used to store images that the user has selected (https://pub.dev/packages/firebase_storage)
-   share_plus: ^9.0.0 - used to share posts and other content from the app to outside social media platforms (https://pub.dev/packages/share_plus)
-   http: ^1.2.1 - used to download online images for post sharing (https://pub.dev/packages/http)
-   path_provider: ^2.1.3 - used to get the temporary directory in which uploaded images are stored to enable sharing across platforms (https://pub.dev/packages/path_provider)
-   screenshot: ^2.3.0 - allows for easy sharing of post content across apps (https://pub.dev/packages/screenshot)

## Copyright

We assure that all work in this project is our own. We did not utilize any previously existing framework to build this, instead building it from scratch.
