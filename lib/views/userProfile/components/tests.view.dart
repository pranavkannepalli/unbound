import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class Tests extends StatelessWidget {
  final List<TestScore> tests;

  const Tests({super.key, required this.tests});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                child: Text("Standardized Tests", style: Theme.of(context).textTheme.displaySmall),
              ),
              IconButton(
                icon: Icon(
                  Ionicons.add_circle,
                  color: blue.shade600,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tests
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          Expanded(
                            child: Text("${e.name} (${e.score})",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                          ),
                          IconButton(
                            icon: Icon(
                              Ionicons.pencil,
                              color: blue.shade600,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Ionicons.trash,
                              color: white.shade700,
                            ),
                            onPressed: () {},
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
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
