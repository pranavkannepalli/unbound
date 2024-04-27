import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/improve.model.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';

class Improvements extends StatefulWidget {
  final UserData? user;
  const Improvements({super.key, required this.user});

  @override
  State<Improvements> createState() => _ImprovementsState();
}

class _ImprovementsState extends State<Improvements> {
  late Future<List<Exercise>> future;

  @override
  void initState() {
    super.initState();
    future = DatabaseService().getImprovements();
  }

  @override
  Widget build(BuildContext context) {
    Widget createCard(Exercise e) {
      return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/exercise", extra: e);
        },
        child: Container(
          width: 215,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: white.shade50,
            border: Border.all(
              width: 1,
              color: white.shade300,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 80,
                color: getColor(e.type),
                padding: const EdgeInsets.all(12),
                alignment: Alignment.bottomLeft,
                child: Icon(
                  getIcon(e.type),
                  size: 24,
                  color: white.shade50,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(e.title, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        e.caption,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white.shade700),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget buildSection(List<Exercise> exercises, String type, List<String> done) {
      var ourExercises = exercises.where((element) => element.type == type && !done.contains(element.id)).toList();
      ourExercises.sort((a, b) => (b.body.length - a.body.length));
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: const EdgeInsets.only(left: 20), child: Text(type, style: Theme.of(context).textTheme.displaySmall)),
          const SizedBox(
            height: 6,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [const SizedBox(width: 14), ...ourExercises.map((e) => createCard(e)), const SizedBox(width: 14)]),
              )),
          const SizedBox(height: 20)
        ],
      );
    }

    Widget buildIndicator(List<Exercise> exercises, String type, List<String> done) {
      final complete = exercises.where((element) => element.type == type && done.contains(element.id)).length /
          exercises.where((element) => element.type == type).length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(type, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(
            height: 12,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Text("${(complete * 100).round()}%",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: getColor(type))),
              SizedBox(
                width: 64,
                height: 64,
                child: CircularProgressIndicator.adaptive(
                  value: complete,
                  valueColor: AlwaysStoppedAnimation<Color>(getColor(type)),
                  strokeCap: StrokeCap.round,
                  backgroundColor: white.shade400,
                ),
              )
            ],
          )
        ],
      );
    }

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          List<Exercise>? exercises = snapshot.data;
          UserData? user = widget.user;
          if (user == null || exercises == null || snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: white.shade200,
              automaticallyImplyLeading: false,
              toolbarHeight: 220,
              titleSpacing: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Improve",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 32),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ["Academics", "Internships", "College", "Profile"]
                            .map((e) => buildIndicator(exercises, e, user.completedExercises))
                            .toList()),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  ...["Academics", "Internships", "College", "Profile"]
                      .map((e) => buildSection(exercises, e, widget.user!.completedExercises))
                ],
              ),
            ),
          );
        });
  }
}

Color getColor(String type) {
  switch (type) {
    case "Academics":
      return green.shade400;
    case "Internships":
      return blue.shade600;
    case "College":
      return purple.shade400;
    default:
      return pink.shade400;
  }
}

IoniconsData getIcon(String type) {
  switch (type) {
    case "Academics":
      return Ionicons.school;
    case "Internships":
      return Ionicons.briefcase;
    case "College":
      return Ionicons.library;
    default:
      return Ionicons.person;
  }
}
