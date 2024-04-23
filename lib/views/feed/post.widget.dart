import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/service/database.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final String uid;
  final String type;
  const PostWidget({super.key, required this.post, required this.uid, required this.type});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late bool liked;
  late int likes;
  @override
  void initState() {
    super.initState();
    setState(() {
      liked = widget.post.likes.contains(widget.uid);
      likes = widget.post.likes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
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
                      backgroundImage: NetworkImage(widget.post.pfp),
                      radius: 17.5,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.post.author, style: Theme.of(context).textTheme.titleSmall),
                          Text(timeToString(widget.post.time),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white.shade700))
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(onPressed: () {}, icon: Icon(Ionicons.person_add, size: 16, color: blue.shade600))
                  ],
                ),
                const SizedBox(height: 12),
                Text(widget.post.text, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.left)
              ],
            ),
          ),
          if (widget.post.photo.isNotEmpty)
            ClipRect(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(widget.post.photo, fit: BoxFit.cover),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            color: white.shade200,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    if (liked) {
                      await DatabaseService(uid: widget.uid).removeLike(widget.post.id, widget.type);
                      setState(() {
                        liked = false;
                        likes--;
                      });
                    } else {
                      await DatabaseService(uid: widget.uid).addLike(widget.post.id, widget.type);
                      setState(() {
                        liked = true;
                        likes++;
                      });
                    }
                  },
                  child: Icon(liked ? Ionicons.heart : Ionicons.heart_outline,
                      size: 18, color: liked ? pink.shade300 : white.shade800),
                ),
                const SizedBox(width: 6),
                Text(likes.toString(), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800)),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext c) {
                          return Container(
                            height: 400,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              color: white.shade50,
                            ),
                            child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                              itemCount: widget.post.comments.length,
                              itemBuilder: (context, index) {
                                Comment comment = widget.post.comments[index];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: white.shade300,
                                      backgroundImage: NetworkImage(comment.pfp),
                                      radius: 17.5,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(comment.author, style: Theme.of(context).textTheme.titleMedium),
                                              const SizedBox(width: 12),
                                              Text(timeToString(comment.time),
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white.shade700))
                                            ],
                                          ),
                                          Text(comment.text, style: Theme.of(context).textTheme.bodyMedium)
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        });
                  },
                  child: Icon(Ionicons.chatbox_ellipses_outline, size: 18, color: white.shade800),
                ),
                const SizedBox(width: 6),
                Expanded(
                    child: Text(widget.post.comments.length.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String timeToString(Timestamp t) {
  DateTime date = t.toDate();
  DateTime now = DateTime.now();
  Duration diff = now.difference(date);
  if (diff.inDays >= 365) {
    return "${(diff.inDays / 365).truncate()} year${(diff.inDays / 365).truncate() > 1 ? "s" : ""} ago";
  }
  if (diff.inDays >= 30) {
    return "${(diff.inDays / 30).truncate()} month${(diff.inDays / 30).truncate() > 1 ? "s" : ""} ago";
  }
  if (diff.inDays >= 7) {
    return "${(diff.inDays / 7).truncate()} week${(diff.inDays / 7).truncate() > 1 ? "s" : ""} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} day${diff.inDays > 1 ? "s" : ""} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} hour${diff.inHours > 1 ? "s" : ""} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} minute${diff.inMinutes > 1 ? "s" : ""} ago";
  }
  return "Just now";
}
