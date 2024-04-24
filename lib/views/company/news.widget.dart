import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/company.model.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/views/feed/post.widget.dart';

class NewsWidget extends StatelessWidget {
  final News news;
  const NewsWidget({super.key, required this.news});
  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<AuthUser?>(context)?.uid;
    if(uid == null) return const Center(child: CircularProgressIndicator());
    Widget buildTweet(Tweet t) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: white.shade50,
              border: Border.all(width: 1, color: white.shade300),
              borderRadius: BorderRadius.circular(12)),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: white.shade400,
                  backgroundImage: NetworkImage(t.photo),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(t.name,
                                style: Theme.of(context).textTheme.labelLarge),
                            const SizedBox(width: 6),
                            if (t.verified)
                              const Icon(Ionicons.checkmark_circle, size: 14)
                          ],
                        ),
                        Text(t.handle,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: white.shade700))
                      ]),
                ),
                const SizedBox(width: 12),
                const Icon(Ionicons.logo_twitter, size: 16)
              ]),
              const SizedBox(height: 12),
              Text(t.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: white.shade800)),
              const SizedBox(height: 12),
              const Spacer(),
              Row(children: [
                Icon(Ionicons.heart_outline, size: 14, color: white.shade700),
                const SizedBox(width: 6),
                Text(likeText(t.likes),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: white.shade700)),
                const Spacer(),
                Text(timeText(t.time),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: white.shade700))
              ])
            ],
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent News",
                    style: Theme.of(context).textTheme.displaySmall),
                Icon(Ionicons.newspaper, size: 24, color: pink.shade400)
              ],
            )),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(width: 14),
                  ...news.tweets.map((e) => buildTweet(e)),
                  const SizedBox(width: 14)
                ],
              ),
            )),
        const SizedBox(height: 20),
        Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: white.shade300, width: 1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Posts", style: Theme.of(context).textTheme.displaySmall),
                Icon(Ionicons.notifications, size: 24, color: purple.shade400)
              ],
            )),
        ...news.posts
            .map((e) => PostWidget(post: e, uid: e.authorUid, type: "Company", authUserId: uid))
      ],
    );
  }
}

String likeText(int likes) {
  if (likes < 1000) return "$likes";
  if (likes < 1000000) {
    if ((likes / 100).round() % 10 == 0) {
      return "${(likes / 1000).round()}K";
    }
    return "${(likes / 100).round() / 10}K";
  }
  if ((likes / 100000).round() % 10 == 0) {
    return "${(likes / 1000000).round()}M";
  }
  return "${(likes / 100000).round() / 10}M";
}

String timeText(Timestamp time) {
  DateTime t = time.toDate();
  return "${t.month}/${t.day}/${t.year} • ${t.hour % 12 == 0 ? "12" : t.hour % 12}:${t.minute} ${t.hour >= 12 ? "PM" : "AM"}";
}
