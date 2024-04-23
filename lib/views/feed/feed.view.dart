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
  const FeedPage({super.key});

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
    future = DatabaseService().getFeeds();
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
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Feed? collegeFeed = (snapshot.data?[0]);
          Feed? studentFeed = (snapshot.data?[1]);
          Feed? companyFeed = (snapshot.data?[2]);
          return SafeArea(
            child: Container(
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
                                Text("Companies", style: Theme.of(context).textTheme.bodySmall)
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
                      ListView.builder(
                          controller: scrollController,
                          itemCount: collegeFeed.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return index != collegeFeed.posts.length - 1
                                ? PostWidget(post: collegeFeed.posts[index], uid: uid, type: "College", authUserId: uid)
                                : Column(children: [
                                    PostWidget(post: collegeFeed.posts[index], uid: uid, type: "College", authUserId: uid),
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
                                  ]);
                          }),
                    if (studentFeed != null)
                      ListView.builder(
                          controller: scrollController,
                          itemCount: studentFeed.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return index != studentFeed.posts.length - 1
                                ? PostWidget(post: studentFeed.posts[index], uid: uid, type: "User", authUserId: uid)
                                : Column(children: [
                                    PostWidget(post: studentFeed.posts[index], uid: uid, type: "User", authUserId: uid),
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
                                  ]);
                          }),
                    if (companyFeed != null)
                      ListView.builder(
                          controller: scrollController,
                          itemCount: companyFeed.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return index != companyFeed.posts.length - 1
                                ? PostWidget(post: companyFeed.posts[index], uid: uid, type: "Company", authUserId: uid)
                                : Column(children: [
                                    PostWidget(post: companyFeed.posts[index], uid: uid, type: "Company", authUserId: uid),
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
                                  ]);
                          }),
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
