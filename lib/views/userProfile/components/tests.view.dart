import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';

class Tests extends StatelessWidget {
  final List<TestScore> tests;
  final GlobalKey headerKey;
  const Tests({super.key, required this.tests, required this.headerKey});

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);

    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 10, color: white.shade300),
          bottom: BorderSide(width: 1.0, color: white.shade300),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            key: headerKey,
            child: Row(
              children: [
                Expanded(
                  child: Text("Standardized Tests", style: Theme.of(context).textTheme.displaySmall),
                ),
                InkWell(
                  child: Icon(
                    Ionicons.add_circle,
                    color: blue.shade600,
                  ),
                  onTap: () {
                    GoRouter.of(context).push('/addTest');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tests
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
                              child: Text("${e.name} (${e.score})",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                            ),
                            InkWell(
                              child: Icon(
                                Ionicons.pencil,
                                color: blue.shade600,
                              ),
                              onTap: () {
                                GoRouter.of(context).push('/editTest', extra: e);
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
                                await DatabaseService(uid: user!.uid).deleteObject("tests", e.toJson());
                              },
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: e.sectionScores.keys
                                .map(
                                  (key) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6.0),
                                      Text(key, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                                      Text(e.sectionScores[key].toString()),
                                    ],
                                  ),
                                )
                                .toList())
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
