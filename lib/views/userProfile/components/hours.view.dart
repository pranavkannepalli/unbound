import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class EditHours extends StatelessWidget {
  final List<CommunityService> hours;
  const EditHours({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    createKVPair(title, data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title:", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
            Text(data.toString()),
            const SizedBox(height: 6.0),
          ],
        );

    Widget buildHour(CommunityService c) {
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
            color: white.shade50, border: Border.all(width: 1, color: white.shade300), borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text("${c.name} (${c.hours})", style: Theme.of(context).textTheme.labelLarge)),
                const Spacer(),
                InkWell(child: Icon(Ionicons.pencil, color: blue.shade600)),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Ionicons.trash,
                      color: white.shade700,
                    )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            createKVPair("Description", c.description)
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
                Text("Community Service", style: Theme.of(context).textTheme.displaySmall),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Ionicons.add_circle,
                      color: blue.shade600,
                    ))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            ...hours.map((e) => buildHour(e))
          ],
        ));
  }
}
