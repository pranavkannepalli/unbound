import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';

class Coursework extends StatelessWidget {
  final List<Course> courses;

  const Coursework({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 1.0, color: white.shade300),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Coursework", style: Theme.of(context).textTheme.displaySmall),
              ),
              IconButton(
                icon: Icon(
                  Ionicons.add_circle,
                  color: blue.shade600,
                ),
                onPressed: () {
                  GoRouter.of(context).push('/addCourse');
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: courses
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          Expanded(
                            child:
                                Text(e.name, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                          ),
                          IconButton(
                            icon: Icon(
                              Ionicons.pencil,
                              color: blue.shade600,
                            ),
                            onPressed: () {
                              GoRouter.of(context).push("/editCourse", extra: e);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Ionicons.trash,
                              color: white.shade700,
                            ),
                            onPressed: () async {
                              await DatabaseService(uid: user!.uid).deleteObject("coursework", e.toJson());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text("Time Period", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                      Text(e.years),
                      const SizedBox(height: 6.0),
                      Text("Description", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                      Text(e.description),
                      const SizedBox(height: 6.0),
                      Text("Score", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                      Text(e.score),
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
