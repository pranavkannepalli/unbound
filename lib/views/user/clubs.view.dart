import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewClubs extends StatefulWidget {
  final List<Club> clubs;
  const ViewClubs({super.key, required this.clubs});

  @override
  State<ViewClubs> createState() => _ViewClubsState();
}

class _ViewClubsState extends State<ViewClubs> {
  late List<ClubItem> clubsDisplay;

  @override
  void initState() {
    super.initState();
    clubsDisplay = widget.clubs.map((e) => ClubItem(club: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: white.shade50,
          border: Border(bottom: BorderSide(width: 1, color: white.shade300))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Clubs", style: Theme.of(context).textTheme.displaySmall),
                Icon(Ionicons.people_circle, size: 24, color: purple.shade400)
              ],
            ),
          ),
          const SizedBox(height: 12),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Column(
              children: clubsDisplay.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ExpansionTile(
                      backgroundColor: white.shade50,
                      childrenPadding: const EdgeInsets.only(left: 40, right: 20),
                      iconColor: white.shade900,
                      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 20),
                      title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(e.club.name, style: Theme.of(context).textTheme.labelLarge),
                              Text(e.club.years, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: purple.shade400))
                            ],
                          ),
                      children:  [
                          if(e.club.roles.isNotEmpty) ...[
                            Text("Roles", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                            RoleDetails(roles: e.club.roles)
                          ],
                          const SizedBox(height: 12),
                          if(e.club.accomplishments.isNotEmpty) ...[
                            Text("Accomplishments", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                            const SizedBox(height: 6),
                            Accomplishments(accomplishments: e.club.accomplishments)
                          ]
                                  
                        ],
                      ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class Accomplishments extends StatelessWidget {
  final List<Accomplishment> accomplishments;
  const Accomplishments({super.key, required this.accomplishments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: accomplishments.map((e) {
        return Column(
          children: [
            Row(
              children: [
                Text(e.place, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: purple.shade400)),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.name, style: Theme.of(context).textTheme.labelLarge),
                    Text("${e.location} • ${e.year}", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white.shade800))
                  ],
                ),
                const SizedBox(width: 12),
                const Spacer(),
                if(e.link.isNotEmpty) InkWell(
                  onTap: () async {
                    final Uri _url = Uri.parse(e.link);
                    if(await canLaunchUrl(_url)) {
                      await launchUrl(_url);
                    }
                  },
                  child: Icon(Ionicons.link, size: 18, color: white.shade700),
                )
              ],
            ),
            const SizedBox(height: 6),
            Text(e.description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade700)),
            const SizedBox(height: 12)
          ],
        );
      }).toList(),
    );
  }
}


class RoleDetails extends StatelessWidget {
  final List<Role> roles;
  const RoleDetails({super.key, required this.roles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: roles.map((e) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(e.name, style: Theme.of(context).textTheme.labelLarge),
            Text(e.years, style:Theme.of(context).textTheme.labelSmall!.copyWith(color: purple.shade400))
          ],
        ),
        Text(e.description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade800)),
        const SizedBox(height: 4)
      ],
    )).toList(),
    );
    
  }
}


class ClubItem {
  Club club;
  bool isExpanded;
  ClubItem({required this.club, this.isExpanded = false});
}

