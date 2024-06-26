import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class Arts extends StatelessWidget {
  final List<Art> arts;

  const Arts({super.key, required this.arts});

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
                child: Text("Arts", style: Theme.of(context).textTheme.displaySmall),
              ),
              InkWell(
                child: Icon(
                  Ionicons.add_circle,
                  color: blue.shade600,
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: arts
                .map(
                  (e) => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: white.shade50,
                        border: Border.all(color: white.shade300, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(e.name,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                            ),
                            InkWell(
                              child: Icon(
                                Ionicons.pencil,
                                color: blue.shade600,
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              child: Icon(
                                Ionicons.trash,
                                color: white.shade700,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Text("Time Period", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                        Text(e.years),
                        const SizedBox(height: 12.0),
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
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
