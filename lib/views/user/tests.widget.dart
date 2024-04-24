import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class ViewTests extends StatelessWidget {
  final List<TestScore> tests;
  const ViewTests({super.key, required this.tests});

  @override
  Widget build(BuildContext context) {

    Widget createTest(TestScore t) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
              Text(t.score, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900))
            ],
          ),
          const SizedBox(height: 4),
          ...t.sectionScores.keys.map((e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade700)),
              Text(t.sectionScores[e], style: Theme.of(context).textTheme.labelMedium!.copyWith(color: white.shade700))
            ],
          )),
          const SizedBox(height: 6)
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 16.0),
      decoration: BoxDecoration(
        color: white.shade50,
        border: Border(
          bottom: BorderSide(width: 1, color: white.shade300)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Standardized Tests", style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.bar_chart, size: 24, color: blue.shade600)
            ],
          ),
          const SizedBox(height: 12),
          ...tests.map((e) => createTest(e))
        ],
      ),
    );
  }
}

