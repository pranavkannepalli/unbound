import 'package:flutter/material.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';
import 'package:unbound/views/user/arts.view.dart';
import 'package:unbound/views/user/clubs.view.dart';
import 'package:unbound/views/user/courses.view.dart';
import 'package:unbound/views/user/sports.view.dart';
import 'package:unbound/views/user/tests.widget.dart';
import 'package:unbound/views/user/workEx.view.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  const UserProfile({super.key, required this.uid});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    createInterests(UserData userData) {
      List<Widget> ints = [];
      final textColor = [blue.shade800, green.shade500, pink.shade500];
      final bgColor = [blue.shade400, green.shade300, pink.shade300];

      for (int i = 0; i < userData.interests.length; i++) {
        Widget n = Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            color: bgColor.elementAt(i % bgColor.length),
          ),
          child: Text(userData.interests.elementAt(i),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: textColor.elementAt(i % textColor.length))),
        );

        ints.add(n);
      }
      return ints;
    }

    return Scaffold(
      body: FutureBuilder(
        future: DatabaseService(uid: widget.uid).getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? user = snapshot.data;
            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
                body: NestedScrollView(
                  clipBehavior: Clip.none,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                      backgroundColor: white.shade50,
                      expandedHeight: 525,
                      collapsedHeight: 525,
                      flexibleSpace: Column(children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                                color: white.shade200,
                                margin: const EdgeInsets.only(bottom: 50),
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                    width: double.infinity,
                                    height: 250,
                                    fit: BoxFit.cover)),
                            Positioned(
                              top: 200,
                              left: 20,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(user.photo),
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
                                  Text(user.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  Text("'${user.grad} @ ${user.school}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: white.shade700)),
                                  const SizedBox(height: 6),
                                  Text(user.bio,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: white.shade700)),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 12.0,
                                    runSpacing: 6.0,
                                    children: createInterests(user),
                                  )
                                ])),
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
                              labelStyle: Theme.of(context).textTheme.bodyMedium,
                              unselectedLabelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: white.shade700),
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: -20),
                              tabs: const [
                                Tab(text: "Academics"),
                                Tab(text: "Activities"),
                                Tab(text: "Experience"),
                                Tab(text: "Posts"),
                              ]),
                        )
                      ]))
                ];
              },
              
              body: TabBarView(
                controller: tabController,
                children: [
                  Column(
                    children: [
                      ViewTests(tests: user.tests),
                      ViewCourses(courses: user.courses)
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ViewClubs(clubs: user.clubs),
                        ViewArts(arts: user.arts),
                        ViewSports(sports: user.sports)
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ViewWorkExperience(works: user.works)
                      ],
                    )
                  ),
                  const Text("Hello"),
                ],
              ),
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
