import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/buttons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/improve.model.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';

class ViewExercise extends StatelessWidget {
  final Exercise exercise;
  const ViewExercise({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<AuthUser?>(context)!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  exercise.title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 12),
                ...exercise.body.split("\n\t").map((e) => Column(children: [
                      Text(e, style: Theme.of(context).textTheme.bodyLarge),
                      const Text(""),
                    ])),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: darkExpand,
                    onPressed: () async {
                      await DatabaseService(uid: uid).completeImprovement(exercise.id);
                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      "Mark as Complete",
                      style: TextStyle(color: white.shade50),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
