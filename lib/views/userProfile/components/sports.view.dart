import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class Sports extends StatelessWidget {
  final List<Sport> sports;

  const Sports({super.key, required this.sports});

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
        border: Border.symmetric(
          horizontal: BorderSide(width: 1.0, color: white.shade300),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Sports", style: Theme.of(context).textTheme.displaySmall),
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
            children: sports
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
                      const SizedBox(height: 6.0),
                      Text("Position", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                      Text(e.position),
                      const SizedBox(height: 12.0),
                      Text(
                        "Stats",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: e.stats.keys
                            .map(
                              (key) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(key, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                                  Text(
                                    e.stats[key],
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      if (e.photos.isNotEmpty)
                        Text(
                          "Photos",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      Row(
                          children: e.photos
                              .map(
                                (url) => Image(
                                  image: NetworkImage(url),
                                  height: 40.0,
                                ),
                              )
                              .toList()),
                      const SizedBox(height: 12.0),
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
                                      createKVPair("Place", e.place),
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
