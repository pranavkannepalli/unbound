import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/model/user.model.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<AuthUser?>(context)?.uid ?? "";
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: white.shade300,
                    backgroundImage: NetworkImage(post.pfp),
                    radius: 17.5,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.author,
                            style: Theme.of(context).textTheme.titleSmall),
                        Text(timeToString(post.time),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: white.shade700))
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Ionicons.person_add,
                          size: 16, color: blue.shade600))
                ],
              ),
              const SizedBox(height: 12),
              Text(post.text,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left)
            ],
          ),
        ),
        if (post.photo.isNotEmpty)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(post.photo, fit: BoxFit.fill),
          ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          color: white.shade200,
          child: Row(children: [
            InkWell(
              onTap: () {},
              child: Icon(post.likes.contains(uid) ? Ionicons.heart : Ionicons.heart_outline, size: 18, color: post.likes.contains(uid) ? pink.shade300: white.shade800),
            ),
            const SizedBox(width: 6),
            Text(post.likes.length.toString(), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800)),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {},
              child: Icon(Ionicons.chatbox_ellipses_outline, size: 18, color: white.shade800),
            ),
            const SizedBox(width: 6),
            Expanded(child: Text(post.comments.length.toString(), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800))),
            
          ]),
        )
      ],
    );
  }
}

String timeToString(Timestamp t) {
  DateTime date = t.toDate();
  DateTime now = DateTime.now();
  Duration diff = now.difference(date);
  if(diff.inDays >= 365) {
    return "${(diff.inDays / 365).truncate()} year${(diff.inDays / 365).truncate() > 1 ? "s": ""} ago";
  }
  if(diff.inDays >= 30) {
    return "${(diff.inDays / 30).truncate()} month${(diff.inDays / 30).truncate() > 1 ? "s": ""} ago";
  }
  if(diff.inDays >= 7) {
    return "${(diff.inDays / 7).truncate()} week${(diff.inDays / 7).truncate() > 1 ? "s": ""} ago";
  }
  if(diff.inDays > 0) {
    return "${diff.inDays} day${diff.inDays > 1 ? "s": ""} ago";
  }
  if(diff.inHours > 0) {
    return "${diff.inHours} hour${diff.inHours > 1 ? "s": ""} ago";
  }
  if(diff.inMinutes > 0) {
    return "${diff.inMinutes} minute${diff.inMinutes > 1 ? "s": ""} ago";
    
  }
  return "Just now";
}