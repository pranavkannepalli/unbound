import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';

class ViewMajors extends StatelessWidget {
  final List<Major> majors;
  const ViewMajors({super.key, required this.majors});

  @override
  Widget build(BuildContext context) {
    Widget createMajor(Major m) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
                Text(m.stat, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: purple.shade400))
              ],
            ),
            Text("${m.students}", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800))
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Majors", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white.shade900)),
              Icon(Ionicons.library, size: 24, color: purple.shade400)
          ]),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Name", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
              Text("Students", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700))
            ],
          ),
          ...majors.map((e) => createMajor(e))
        ],
      ),
    );
  }
}