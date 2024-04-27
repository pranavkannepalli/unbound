import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class ViewHours extends StatelessWidget {
  final List<CommunityService> hours;
  const ViewHours({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    Widget buildHour(CommunityService c) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(c.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
              Text(
                "${c.hours} hrs.",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: purple.shade400),
              )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            c.description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade800),
          ),
          const SizedBox(
            height: 12,
          )
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Community Service", style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.medal, size: 24, color: purple.shade400)
            ],
          ),
          const SizedBox(height: 12),
          ...hours.map((e) => buildHour(e))
        ],
      ),
    );
  }
}
