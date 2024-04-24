import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewSports extends StatelessWidget {
  final List<Sport> sports;
  const ViewSports({super.key, required this.sports});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sports", style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.football, size: 24, color: yellow.shade500)
            ],
          ),
          const SizedBox(height: 12),
          ...sports.map((e) => SportSection(sport: e))
        ],
      ),
    );
  }
}

class SportSection extends StatelessWidget {
  final Sport sport;
  const SportSection({super.key, required this.sport});

  @override
  Widget build(BuildContext context) {
    List<Widget> createStats(Map<String, dynamic> stats) {
      return stats.keys
          .map((k) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("$k: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: white.shade800)),
                  Text("${stats[k]}",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: yellow.shade500))
                ],
              ))
          .toList();
    }

    Widget createAccomplishment(Accomplishment e) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: (Row(
          children: [
            Text(e.place,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: yellow.shade500)),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.name, style: Theme.of(context).textTheme.labelLarge),
                Text("${e.location} • ${e.year}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: white.shade800))
              ],
            ),
            const SizedBox(width: 12),
            const Spacer(),
            if (e.link.isNotEmpty)
              InkWell(
                onTap: () async {
                  final Uri _url = Uri.parse(e.link);
                  if (await canLaunchUrl(_url)) {
                    await launchUrl(_url);
                  }
                },
                child: Icon(Ionicons.link, size: 18, color: white.shade700),
              )
          ],
        )),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(sport.years,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: yellow.shade500)),
                  Text(sport.name,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: white.shade900))
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: yellow.shade400),
              child: Text(sport.position,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: yellow.shade600)),
            )
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          children: createStats(sport.stats),
        ),
        const SizedBox(height: 6),
        Theme(
          data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              listTileTheme: ListTileTheme.of(context).copyWith(
                  dense: true,
                  minVerticalPadding: 0,
                  visualDensity: VisualDensity.compact)),
          child: ExpansionTile(
              shape: InputBorder.none,
              iconColor: white.shade700,
              tilePadding: EdgeInsets.zero,
              title: Text("Accomplishments",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: white.shade700)),
              children: sport.accomplishments
                  .map((e) => createAccomplishment(e))
                  .toList()),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
