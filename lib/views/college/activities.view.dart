import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';

class ViewActivities extends StatelessWidget {
  final List<Activity> activities;
  const ViewActivities({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    Widget buildStars(int count) {
      return Row(
        children: [
          for (int i = 0; i < count; i++)
            Icon(Ionicons.star, color: yellow.shade400, size: 14,),
          for(int i = count; i < 5; i++) Icon(Ionicons.star_outline, color: yellow.shade400, size: 14,)
        ],
      );
    }

    Widget buildActivity(Activity a) {
      return Container(
        width: 215,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(a.photo, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(a.name,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: white.shade900)),
                const Spacer(),
                Icon(Ionicons.location, color: green.shade400, size: 14),
                const SizedBox(width: 6),
                Text(a.distance,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: green.shade400))
              ],
            ),
            const SizedBox(height: 6),
            Text(a.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: white.shade800)),
            const SizedBox(height: 6),
            Row(
              children: [
                buildStars(a.stars),
                const SizedBox(width: 12),
                Text("${a.number}", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700))
              ],
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: white.shade300)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Activities",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: white.shade900)),
                Icon(Ionicons.baseball, size: 24, color: green.shade400)
              ],
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                ...activities.map((e) => buildActivity(e)),
                const SizedBox(width: 8)
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
