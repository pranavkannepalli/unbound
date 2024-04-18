import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/feed.model.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
                        Text(post.time.toString(),
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
              child: Icon(Ionicons.heart_outline, size: 18, color: white.shade800),
            ),
            const SizedBox(width: 6),
            Text(post.likes.toString(), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800)),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {},
              child: Icon(Ionicons.chatbox_ellipses_outline, size: 18, color: white.shade800),
            ),
            const SizedBox(width: 6),
            Expanded(child: Text(post.comments.length.toString(), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800))),
            InkWell(
              onTap: () {},
              child: Icon(Ionicons.bookmark_outline, size: 18, color: white.shade800),
            )
          ]),
        )
      ],
    );
  }
}
