import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';

class Works extends StatelessWidget {
  final List<Work> works;

  const Works({super.key, required this.works});

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
                child: Text("Work Experience", style: Theme.of(context).textTheme.displaySmall),
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
            children: works
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(e.name,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
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
                        Text("Description", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                        Text(e.description),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
