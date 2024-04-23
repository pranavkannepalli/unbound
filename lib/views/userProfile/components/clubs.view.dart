import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class Clubs extends StatelessWidget {
  final List<Club> clubs;
  final GlobalKey headerKey;
  const Clubs({super.key, required this.clubs, required this.headerKey});

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

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 10.0, color: white.shade300),
          bottom: BorderSide(width: 1.0, color: white.shade300),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            key: headerKey,
            children: [
              Expanded(
                child: Text("Clubs", style: Theme.of(context).textTheme.displaySmall),
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
            children: clubs
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child:
                                Text(e.name, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
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
                      const SizedBox(height: 6.0),
                      Text("Time Period", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                      Text(e.years),
                      const SizedBox(height: 12.0),
                      Text(
                        "Roles",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: e.roles
                              .map((e) => Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6.0),
                                      Text(
                                        e.name,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      createKVPair("Description", e.description),
                                      createKVPair("Time Period", e.years),
                                    ],
                                  ))
                              .toList()),
                      Text(
                        "Accomplishments",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: e.accomplishments
                              .map((e) => Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6.0),
                                      Text(
                                        e.name,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      createKVPair("Location", e.location),
                                      createKVPair("Year", e.year),
                                      e.link.isNotEmpty ? createKVPair("Link", e.link) : const SizedBox(height: 0.0),
                                      createKVPair("Place", "#${e.place}"),
                                    ],
                                  ))
                              .toList()),
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
