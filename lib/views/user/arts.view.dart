
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewArts extends StatelessWidget {
  final List<Art> arts;
  const ViewArts({super.key, required this.arts});

  @override
  Widget build(BuildContext context) {
    Widget createAccomplishment(Accomplishment e) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: (Row(
          children: [
            Text(e.place,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: pink.shade400)),
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

    Widget createArt(Art a) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(a.years,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: pink.shade400)),
          Text(a.name,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: white.shade900)),
          const SizedBox(height: 6),
          Text(a.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: white.shade800)),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push("/gallery", extra: a.photos);
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...a.photos.take(2).map((e) => Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        e,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  if(a.photos.length > 2) Text("+${a.photos.length - 2} more")
                ],
              ),
            ),
          ),
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
                children: a.accomplishments
                    .map((e) => createAccomplishment(e))
                    .toList()),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: white.shade50,
        border: Border(bottom: BorderSide(color: white.shade300, width: 1))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Arts & Humanities",
                  style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.brush, size: 24, color: pink.shade400)
            ],
          ),
          const SizedBox(height: 12),
          ...arts.map((e) => createArt(e))
        ],
      ),
    );
  }
}
