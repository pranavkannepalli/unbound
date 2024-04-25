import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/text_input.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';
import 'package:unbound/views/feed/post.widget.dart';

class FeedPage extends StatefulWidget {
  final UserData? initial;

  const FeedPage({super.key, required this.initial});

  @override
  State<FeedPage> createState() => _FeedState();
}

class _FeedState extends State<FeedPage> with SingleTickerProviderStateMixin {
  late TabController controller;
  late Future<List<Feed>?> future;
  late ScrollController scrollController;
  int currentIndex = 0;
  double scrollPos = 0;

  void handleTabChange() {
    setState(() {
      currentIndex = controller.index;
      scrollPos = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    future = DatabaseService().getFeeds(widget.initial!.name, widget.initial!.following);
    controller = TabController(length: 3, vsync: this);
    controller.addListener(handleTabChange);
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {
        scrollPos = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<AuthUser?>(context)?.uid ?? "";
    final UserData? user = Provider.of<UserData?>(context);
    Widget accountInfo(Account acc, String type, bool following) {
      Map<String, dynamic> colors = {"Company": blue.shade600, "Student": green.shade400, "College": purple.shade400};
      Map<String, dynamic> pageRoutes = {"Student": "user", "Company": "company", "College": "college"};
      return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/${pageRoutes[type]}", extra: acc.uid);
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: white.shade500.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4))],
              borderRadius: BorderRadius.circular(8),
              image: acc.pfp.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(acc.pfp),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(white.shade900.withOpacity(0.75), BlendMode.srcOver))
                  : null,
              color: acc.pfp.isEmpty ? white.shade400 : null),
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.only(right: 12),
          width: 150,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(acc.name, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: white.shade50)),
              const SizedBox(height: 6),
              InkWell(
                  onTap: () {
                    if (following) {
                      DatabaseService(uid: uid).unfollowAccount(acc.uid);
                    } else {
                      DatabaseService(uid: uid).followAccount(acc.uid);
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: colors[type], borderRadius: BorderRadius.circular(4)),
                      child: Text(following ? "Following" : "Follow",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade50))))
            ],
          ),
        ),
      );
    }

    Widget recommended(String type, List<String> following, List<Account> accs) {
      return Container(
        clipBehavior: Clip.none,
        color: white.shade200,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(type != "Company" ? "${type}s to Follow" : "Companies to Follow",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white.shade800)),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [const SizedBox(width: 20), ...accs.map((e) => accountInfo(e, type, following.contains(e.uid)))],
              ),
            )
          ],
        ),
      );
    }

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (user != null && snapshot.connectionState == ConnectionState.done) {
          Feed? collegeFeed = (snapshot.data?[0]);
          Feed? studentFeed = (snapshot.data?[1]);
          Feed? companyFeed = (snapshot.data?[2]);
          print(collegeFeed?.recommended.length);
          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: white.shade50,
                      boxShadow: scrollPos > 0 ? [const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 16)] : []),
                  child: Column(
                    children: [
                      TextField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Search", prefixIcon: Icon(Ionicons.search, size: 16, color: white.shade700)),
                        style: Theme.of(context).textTheme.bodyLarge,
                        onSubmitted: (value) => GoRouter.of(context).push("/search", extra: value),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: white.shade400, borderRadius: BorderRadius.circular(10)),
                        child: TabBar(
                          controller: controller,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                              color: white.shade50,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 8)]),
                          tabs: [
                            Tab(
                              height: 30,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(currentIndex == 0 ? Ionicons.library : Ionicons.library_outline,
                                    size: 14, color: currentIndex == 0 ? purple.shade400 : white.shade700),
                                const SizedBox(width: 8),
                                Text("Colleges", style: Theme.of(context).textTheme.bodySmall)
                              ]),
                            ),
                            Tab(
                              height: 30,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(currentIndex == 1 ? Ionicons.people : Ionicons.people_outline,
                                    size: 14, color: currentIndex == 1 ? green.shade400 : white.shade700),
                                const SizedBox(width: 8),
                                Text("People", style: Theme.of(context).textTheme.bodySmall)
                              ]),
                            ),
                            Tab(
                              height: 30,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(currentIndex == 2 ? Ionicons.briefcase : Ionicons.briefcase_outline,
                                    size: 14, color: currentIndex == 2 ? blue.shade600 : white.shade700),
                                const SizedBox(width: 8),
                                Text("Jobs", style: Theme.of(context).textTheme.bodySmall)
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  controller: controller,
                  children: [
                    if (collegeFeed != null)
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            if (collegeFeed.recommended.isNotEmpty)
                              recommended("College", user.following, collegeFeed.recommended),
                            ...collegeFeed.posts.map((e) => PostWidget(post: e, uid: uid, type: "College", authUserId: uid)),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(Ionicons.book, color: white.shade500, size: 36),
                                  const SizedBox(height: 12),
                                  Text("That's Enough For Today",
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800)),
                                  Text("Time to hit the books, the bed, or the buddies",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade800))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    if (studentFeed != null)
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            if (studentFeed.recommended.isNotEmpty)
                              recommended("Student", user.following, studentFeed.recommended),
                            ...studentFeed.posts.map((e) => PostWidget(post: e, uid: uid, type: "Student", authUserId: uid)),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(Ionicons.book, color: white.shade500, size: 36),
                                  const SizedBox(height: 12),
                                  Text("That's Enough For Today",
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800)),
                                  Text("Time to hit the books, the bed, or the buddies",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade800))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    if (companyFeed != null)
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            if (companyFeed.recommended.isNotEmpty)
                              recommended("Company", user.following, companyFeed.recommended),
                            ...companyFeed.posts.map((e) => PostWidget(post: e, uid: uid, type: "Company", authUserId: uid)),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(Ionicons.book, color: white.shade500, size: 36),
                                  const SizedBox(height: 12),
                                  Text("That's Enough For Today",
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800)),
                                  Text("Time to hit the books, the bed, or the buddies",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade800))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ))
              ]),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
