import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:image_picker/image_picker.dart";
import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";
import "package:unbound/views/userProfile/components/arts.view.dart";
import "package:unbound/views/userProfile/components/clubs.view.dart";
import "package:unbound/views/userProfile/components/coursework.view.dart";
import "package:unbound/views/userProfile/components/projects.view.dart";
import "package:unbound/views/userProfile/components/sports.view.dart";
import "package:unbound/views/userProfile/components/tests.view.dart";
import "package:unbound/views/userProfile/components/work.view.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final List<GlobalKey> editCategories = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];

  late TabController controller;
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(animateToTab);
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void animateToTab() {
    late RenderBox box;

    for (var i = 0; i < editCategories.length; i++) {
      box = editCategories[i].currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);

      if (scrollController.offset >= position.dy) {
        controller.animateTo(i, duration: const Duration(milliseconds: 200));
      }
    }
  }

  void showEditPfp(String uid) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    style: textExpand,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Ionicons.trash, size: 18, color: white.shade700),
                        const SizedBox(width: 12.0),
                        Text(
                          "Delete Image",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: white.shade700),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await DatabaseService(uid: uid).updateUserData({"photo": ""});
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: textExpand,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Ionicons.image, size: 18, color: white.shade700),
                        const SizedBox(width: 10.0),
                        Text(
                          "Select from Gallery",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: white.shade700),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        await DatabaseService(uid: uid).changePfp(file);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: textExpand,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Ionicons.camera, size: 18, color: white.shade700),
                        const SizedBox(width: 10.0),
                        Text(
                          "Take Picture",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: white.shade700),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (file != null) {
                        await DatabaseService(uid: uid).changePfp(file);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ));
  }

  void scrollToIndex(int index) async {
    scrollController.removeListener(animateToTab);
    final categories = editCategories[index].currentContext!;
    await Scrollable.ensureVisible(categories, duration: const Duration(milliseconds: 600));
    scrollController.addListener(animateToTab);
  }

  @override
  Widget build(BuildContext context) {
    UserData? userData = Provider.of<UserData?>(context);
    AuthUser? user = Provider.of<AuthUser?>(context);
    const gap = SizedBox(height: 6.0);
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    createKVPair(title, data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title:", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
            Text(data.toString()),
            gap
          ],
        );

    createInterests() {
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
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor.elementAt(i % textColor.length))),
        );

        ints.add(n);
      }
      return ints;
    }

    createBasicInfo(int index, UserData data) {
      return Container(
        padding: const EdgeInsets.only(right: 20.0, bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(width: 1.0, color: white.shade300),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20, key: editCategories[index]),
            Center(
              child: TextButton(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: white.shade300,
                      backgroundImage: NetworkImage(userData.photo),
                      radius: 60,
                    ),
                    Icon(
                      Ionicons.camera,
                      color: white.shade700,
                    ),
                  ],
                ),
                onPressed: () => showEditPfp(user!.uid),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text("Basic Info", style: Theme.of(context).textTheme.displaySmall),
                ),
                IconButton(
                  icon: Icon(
                    Ionicons.pencil,
                    color: blue.shade600,
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/editBasicInfo', extra: userData);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            createKVPair("Name", data.name),
            createKVPair("Grad Year", data.grad),
            createKVPair("School", data.school),
            createKVPair("Bio", data.bio),
            Wrap(
              spacing: 12.0,
              runSpacing: 6.0,
              children: createInterests(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white.shade50,
        surfaceTintColor: white.shade100,
        title: Text("Edit Profile", style: Theme.of(context).textTheme.displaySmall),
        bottom: TabBar(
          controller: controller,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return white.shade300;
            }
            return Colors.transparent;
          }),
          indicator: BoxDecoration(border: Border(bottom: BorderSide(color: white.shade900, width: 2))),
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade700),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: -20),
          tabs: const [Tab(text: "Basic"), Tab(text: "Academics"), Tab(text: "Extracurriculars"), Tab(text: "Experiences")],
          onTap: (int index) => scrollToIndex(index),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            createBasicInfo(0, userData),
            Tests(tests: userData.tests, headerKey: editCategories[1]),
            Coursework(courses: userData.courses),
            Clubs(clubs: userData.clubs, headerKey: editCategories[2]),
            Arts(arts: userData.arts),
            Sports(sports: userData.sports),
            Works(works: userData.works, headerKey: editCategories[3]),
            Projects(projects: userData.projects)
          ],
        ),
      ),
    );
  }
}

// SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 60),
//           Center(
//             child: CircleAvatar(
//               backgroundColor: white.shade300,
//               backgroundImage: NetworkImage(userData!.photo),
//               radius: 60,
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           TabBar(
//             controller: controller,
//             overlayColor: MaterialStateProperty.resolveWith((states) {
//               if (states.contains(MaterialState.pressed)) {
//                 return white.shade300;
//               }
//               return Colors.transparent;
//             }),
//             indicator: BoxDecoration(
//                 border: Border(
//                     bottom: BorderSide(color: white.shade900, width: 2))),
//             labelPadding: const EdgeInsets.symmetric(horizontal: 20),
//             labelStyle: Theme.of(context).textTheme.bodyMedium,
//             indicatorPadding: const EdgeInsets.symmetric(horizontal: -20),
//             tabs: const [
//               Tab(
//                 text: "Academics",
//               ),
//               Tab(
//                 text: "Activities",
//               ),
//               Tab(
//                 text: "Experiences",
//               ),
//             ],
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: TabBarView(
//               controller: controller,
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Tests(tests: userData.tests),
//                       Coursework(courses: userData.courses),
//                     ],
//                   ),
//                 ),
//                 SingleChildScrollView(
//                   child: Clubs(clubs: userData.clubs),
//                 ),
//                 SingleChildScrollView(
//                   child: Text("Experiences"),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
