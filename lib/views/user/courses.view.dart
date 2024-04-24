import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class ViewCourses extends StatelessWidget {
  final List<Course> courses;
  const ViewCourses({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    Widget createCourse(Course c) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.years,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: green.shade400)),
                    Text(c.name,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: white.shade900))
                  ],
                ),
              ),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: green.shade400,
                    borderRadius: BorderRadius.circular(12.5)),
                child: Center(
                    child: Text(c.score,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: white.shade50))),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text(c.description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade700)),
          const SizedBox(height: 12)
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: white.shade50,
          border: Border(bottom: BorderSide(width: 1, color: white.shade300))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Coursework",
                  style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.book, size: 24, color: green.shade400)
            ],
          ),
          const SizedBox(height: 12),
          ...courses.map((e) => createCourse(e))
        ],
      ),
    );
  }
}
