import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class ViewWorkExperience extends StatelessWidget {
  final List<Work> works;
  const ViewWorkExperience({super.key, required this.works});

  @override
  Widget build(BuildContext context) {
    Widget createWork(Work w) {
      return Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: white.shade400,
                backgroundImage: NetworkImage(w.photo),
                radius: 15,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(w.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
                    Text(w.years, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: purple.shade400))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(w.description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade700)),
          const SizedBox(height: 20)
        ],
      );
    }


    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
        decoration: BoxDecoration(
            color: white.shade50,
            border:
                Border(bottom: BorderSide(width: 1, color: white.shade300))),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Work Experience", style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.briefcase, size: 24, color: blue.shade600)
            ],
          ),
          const SizedBox(height: 12),
          ...works.map((e) => createWork(e))
        ]));
  }
}
