import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewHighlights extends StatelessWidget {
  final List<Highlight> highlights;
  const ViewHighlights({super.key, required this.highlights});

  @override
  Widget build(BuildContext context) {
    Widget createHighlight(Highlight h) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(h.number, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: yellow.shade500)),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(h.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
                  Text("${h.source} • ${h.date.toDate().year}",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade800)),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            if (h.link.isNotEmpty)
              InkWell(
                  onTap: () async {
                    Uri url = Uri.parse(h.link);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Icon(Ionicons.link, color: white.shade700, size: 18)),
          ],
        ),
      );
    }

    return Container(
        padding: const EdgeInsets.only(top: 16, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(color: white.shade50, border: Border(bottom: BorderSide(color: white.shade300, width: 1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Highlights", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white.shade900)),
                Icon(Ionicons.podium, size: 24, color: yellow.shade500)
              ],
            ),
            const SizedBox(height: 12),
            ...highlights.map((e) => createHighlight(e))
          ],
        ));
  }
}
