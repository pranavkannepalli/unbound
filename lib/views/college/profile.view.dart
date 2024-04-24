import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/buttons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';
import 'package:unbound/views/college/activities.view.dart';
import 'package:unbound/views/college/highlights.view.dart';
import 'package:unbound/views/college/majors.view.dart';
import 'package:unbound/views/college/organizations.view.dart';
import 'package:unbound/views/college/quickStats.view.dart';
import 'package:unbound/views/college/reviews.view.dart';
import 'package:unbound/views/college/stat.widget.dart';
import 'package:unbound/views/feed/post.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CollegeProfile extends StatefulWidget {
  final String uid;
  const CollegeProfile({super.key, required this.uid});

  @override
  State<CollegeProfile> createState() => _CollegeProfileState();
}

class _CollegeProfileState extends State<CollegeProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget createDeadline(String text, Timestamp time) {
      DateTime t = time.toDate();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: white.shade800)),
          Text("${t.month}/${t.day}",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: purple.shade400))
        ],
      );
    }

    Widget createApplicationDetails(ApplicationInfo info) {
      Timestamp? earlyDecision = info.earlyDecision;
      Timestamp? regularDecision = info.regularDecision;
      Timestamp? transfer = info.transfer;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Thinking of Applying?",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: white.shade900)),
          const SizedBox(height: 12),
          if (earlyDecision != null)
            createDeadline("Early Decision", earlyDecision),
          const SizedBox(height: 6),
          if (regularDecision != null)
            createDeadline("Regular Decision", regularDecision),
          const SizedBox(height: 6),
          if (transfer != null) createDeadline("Transfer", transfer),
          const SizedBox(height: 12),
          if (info.link.isNotEmpty)
            ElevatedButton(
                style: darkExpand,
                onPressed: () async {
                  Uri url = Uri.parse(info.link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Ionicons.enter, color: white.shade50, size: 18),
                  const SizedBox(width: 12),
                  Text("Go To Applications",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: white.shade50))
                ]))
        ],
      );
    }

    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          DatabaseService(uid: widget.uid).getCollegeData(widget.uid),
          DatabaseService(uid: widget.uid).getCollegePosts(widget.uid)
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic>? data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            College college = data[0];
            List<Post> posts = data[1];
            String userId = Provider.of<AuthUser?>(context)?.uid ?? "";
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: white.shade50,
                      expandedHeight: 925,
                      collapsedHeight: 925,
                      automaticallyImplyLeading: false,
                      leading: InkWell(onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: Icon(Ionicons.arrow_back, size: 24, color: white.shade50,)),
                      flexibleSpace: Column(
                        children: [
                          Stack(
                            alignment: Alignment.centerLeft,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: white.shade200,
                                margin: EdgeInsets.only(bottom: 50),
                                child: Image.network(
                                  college.bgImg,
                                  width: double.infinity,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 200,
                                left: 20,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(college.photo),
                                  backgroundColor: white.shade400,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(college.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                Text("${college.type} @ ${college.location}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: white.shade700)),
                                const SizedBox(height: 6),
                                Text(college.bio,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: white.shade700)),
                                const SizedBox(height: 12),
                                createStatsRow(
                                    college.quickStats.take(2).toList()),
                                const SizedBox(height: 12),
                                createStatsRow(college.quickStats
                                    .skip(2)
                                    .take(2)
                                    .toList()),
                                const SizedBox(height: 12),
                                createStatsRow(college.quickStats
                                    .skip(4)
                                    .take(2)
                                    .toList()),
                                const SizedBox(height: 12),
                                createApplicationDetails(
                                    college.applicationInfo)
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TabBar(
                                controller: tabController,
                                isScrollable: true,
                                tabAlignment: TabAlignment.start,
                                overlayColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return white.shade300;
                                  }
                                  return Colors.transparent;
                                }),
                                indicator: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: white.shade900, width: 2))),
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                labelStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                unselectedLabelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: white.shade700),
                                indicatorPadding:
                                    const EdgeInsets.symmetric(horizontal: -20),
                                tabs: const [
                                  Tab(text: "Academics"),
                                  Tab(text: "Campus Life"),
                                  Tab(text: "Posts"),
                                ]),
                          )
                        ],
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          if (college.highlights.isNotEmpty)
                            ViewHighlights(highlights: college.highlights),
                          if (college.majors.isNotEmpty)
                            ViewMajors(majors: college.majors)
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          QuickStats(
                              diversity: college.diversity,
                              livingStats: college.livingStats),
                          if (college.activities.isNotEmpty)
                            ViewActivities(activities: college.activities),
                          if (college.organizations.isNotEmpty)
                            ViewOrganizations(
                                organizations: college.organizations),
                          if (college.reviews.isNotEmpty)
                            ViewReviews(reviews: college.reviews)
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...posts.map((e) => PostWidget(
                              post: e,
                              uid: e.authorUid,
                              type: "College",
                              authUserId: userId)),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Icon(Ionicons.book,
                                    color: white.shade500, size: 36),
                                const SizedBox(height: 12),
                                Text("That's Enough For Today",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: white.shade800)),
                                Text(
                                    "Time to hit the books, the bed, or the buddies",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: white.shade800))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
