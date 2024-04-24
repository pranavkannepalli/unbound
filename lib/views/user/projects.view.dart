import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class ViewProjects extends StatelessWidget {
  final List<Project> projects;
  const ViewProjects({super.key, required this.projects});


  @override
  Widget build(BuildContext context) {
    Widget createProject(Project p) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(p.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
          Text(p.years, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: green.shade400)),
          const SizedBox(height: 6),
          Text(p.description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade700)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: p.skills.map((e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: white.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(e, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade800)),
            )).toList(),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push("/gallery", extra: p.photos);
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...p.photos.take(2).map((e) => Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        e,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  if(p.photos.length > 2) Text("+${p.photos.length - 2} more")
                ],
              ),
            ),
          ),
        ],
      );
    }


    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: white.shade50,
        border: Border(bottom: BorderSide(color: white.shade300, width: 1))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Projects",
                  style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.shapes, size: 24, color: green.shade400)
            ],
          ),
          const SizedBox(height: 12),
          ...projects.map((e) => createProject(e))
        ],
      ),
    );
  }
}