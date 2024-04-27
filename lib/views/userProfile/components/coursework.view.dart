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
              InkWell(
                child: Icon(
                  Ionicons.add_circle,
                  color: blue.shade600,
                ),
                onTap: () {
                  GoRouter.of(context).push('/addCourse');
                },
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: courses
                .map(
                  (e) => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: white.shade50,
                        border: Border.all(color: white.shade300, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(e.name,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                            ),
                            InkWell(
                              child: Icon(
                                Ionicons.pencil,
                                color: blue.shade600,
                              ),
                              onTap: () {
                                GoRouter.of(context).push("/editCourse", extra: e);
                              },
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              child: Icon(
                                Ionicons.trash,
                                color: white.shade700,
                              ),
                              onTap: () async {
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
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
