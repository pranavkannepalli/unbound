import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/auth.dart';
import 'package:unbound/settings/settings.view.dart';
import 'package:unbound/views/feed/feed.view.dart';
import 'package:unbound/views/improve/improve.view.dart';
import 'package:unbound/views/userProfile/userProfile.view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    List<Widget> widgetOptions = <Widget>[
      FeedPage(initial: userData),
      Improvements(user: userData),
      const ProfileScreen(),
      const Settings(),
    ];

    if (userData != null) {
      return Scaffold(
        body: widgetOptions.elementAt(index),
        appBar: index == 0
            ? AppBar(
                backgroundColor: white.shade50,
                automaticallyImplyLeading: false,
                toolbarHeight: 80,
                titleSpacing: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 30, left: 10),
                        child: IconButton(
                            onPressed: () {
                              GoRouter.of(context).push("/createPost");
                            },
                            icon: const Icon(Ionicons.add_circle_outline))),
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text("Your Feed", style: Theme.of(context).textTheme.displaySmall)),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 10),
                      child: IconButton(onPressed: () {}, icon: const Icon(Ionicons.notifications_outline)),
                    )
                  ],
                ),
              )
            : null,
        bottomNavigationBar: MediaQuery(
          data: const MediaQueryData(
            viewPadding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 12.0,
            showSelectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            showUnselectedLabels: false,
            currentIndex: index,
            onTap: (value) => setState(() => index = value),
            selectedItemColor: getColor(index),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Ionicons.newspaper,
                    size: 20.0,
                  ),
                ),
                label: "Feed",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Ionicons.sparkles,
                    size: 20.0,
                  ),
                ),
                label: "Improve",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Ionicons.person,
                    size: 20.0,
                  ),
                ),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Ionicons.settings,
                    size: 20.0,
                  ),
                ),
                label: "Settings",
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                child: const Text("Go home!"),
                onPressed: () => GoRouter.of(context).go('/'),
              ),
              TextButton(
                child: const Text("Sign Out!"),
                onPressed: () async {
                  await AuthService().signOut();
                  GoRouter.of(context).go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
