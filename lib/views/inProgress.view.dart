import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/auth.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  int index = 0;

  Color getColor(int index) {
    if (index == 0) return const Color(0xFF9881A6);
    if (index == 1) return const Color(0xFF7194A6);
    if (index == 2) return const Color(0xFF8BA394);
    return const Color(0xFFAA6685);
  }

  @override
  Widget build(BuildContext context) {
    UserData? userData = Provider.of<UserData?>(context);

    if (userData != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(userData.name ?? ""),
              TextButton(
                child: const Text("Go home!"),
                onPressed: () async {
                  await AuthService().signOut();
                  GoRouter.of(context).go('/landing');
                },
              ),
              TextButton(
                child: const Text("Create post!"),
                onPressed: () async {
                  GoRouter.of(context).go('/createPost');
                },
              ),
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/unbound-fbla.appspot.com/o/images%2FzkpytvvqE5RWYLGkUZoRy0eIgZW2Timestamp(seconds%3D1713402476%2C%20nanoseconds%3D272624000)?alt=media&token=e18a5eca-f994-496b-8381-c4c11d8c4aec",
                width: 200,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12.0,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: index,
          onTap: (value) => setState(() => index = value),
          selectedItemColor: getColor(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.newspaper,
                size: 20.0,
              ),
              label: "Feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.sparkles,
                size: 20.0,
              ),
              label: "Improve",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.person,
                size: 20.0,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.settings,
                size: 20.0,
              ),
              label: "Settings",
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: TextButton(
            child: const Text("Go home!"),
            onPressed: () => GoRouter.of(context).go('/splash'),
          ),
        ),
      ),
    );
  }
}
