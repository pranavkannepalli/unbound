import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewOrganizations extends StatelessWidget {
  final List<Organization> organizations;
  const ViewOrganizations({super.key, required this.organizations});

  @override
  Widget build(BuildContext context) {
    Widget buildOrganization(Organization o) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(o.photo),
              backgroundColor: white.shade400,
              radius: 15,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(o.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
                  Text("${o.members} members", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: pink.shade400))
                ],
              ),
            ),
            if(o.link.isNotEmpty) InkWell(
              onTap: () async {
                Uri url = Uri.parse(o.link);
                if(await canLaunchUrl(url)) await launchUrl(url);
              },
              child: Icon(Ionicons.link, size: 18, color: white.shade700),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: white.shade300, width: 1)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Student Organizations", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white.shade900)),
              Icon(Ionicons.people_circle, size: 24, color: pink.shade400)
          ]),
          const SizedBox(height: 12),
          ...organizations.map((e) => buildOrganization(e))
        ],
      ),
    );
  }
}