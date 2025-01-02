import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unbound/common/text_input.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final String uid;
  final String type;
  final String authUserId;
  const PostWidget({super.key, required this.post, required this.uid, required this.type, required this.authUserId});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late bool liked;
  late int likes;
  final commentController = TextEditingController();
  String commentText = "";
  late List<Comment> comments;
  @override
  void initState() {
    super.initState();
    setState(() {
      liked = widget.post.likes.contains(widget.authUserId);
      likes = widget.post.likes.length;
      comments = widget.post.comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? auth = Provider.of<AuthUser?>(listen: false, context)?.uid ?? "";
    UserData? user = Provider.of<UserData?>(listen: false, context);

    void addComment() {
      var c = comments;
      var nComment = Comment(
        author: user?.name ?? "",
        text: commentText,
        time: Timestamp.now(),
        pfp: user?.photo ?? "",
        uid: auth,
      );
      c.add(nComment);
      setState(() {
        commentController.clear();
        commentText = "";
        comments = c;
        DatabaseService().addComment(widget.post.id, widget.uid, widget.type, nComment);
      });
    }

    Map<String, dynamic> pageRoutes = {"Student": "user", "Company": "company", "College": "college"};

    return Container(
      decoration: BoxDecoration(color: white.shade50),
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
                    GestureDetector(
                      onTap: () => GoRouter.of(context).push('/${pageRoutes[widget.type]}', extra: widget.post.authorUid),
                      child: CircleAvatar(
                        backgroundColor: white.shade300,
                        backgroundImage: NetworkImage(widget.post.pfp),
                        radius: 17.5,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => GoRouter.of(context).push('/${pageRoutes[widget.type]}', extra: widget.post.authorUid),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.post.author, style: Theme.of(context).textTheme.titleSmall),
                            Text(timeToString(widget.post.time),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white.shade700))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () async {
                        try {
                          String tempPath = (await getTemporaryDirectory()).path;
                          File photo = File('$tempPath/${widget.post.id}.png');

                          XFile file = XFile(photo.path);
                          await Share.shareXFiles([file]);
                          print("tried sharing");
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      icon: Icon(Ionicons.share, size: 16, color: blue.shade600),
                    ),
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
                    print("id ${widget.post.id}");
                    if (liked) {
                      await DatabaseService(uid: auth).removeLike(widget.post.id, widget.type);
                      setState(() {
                        liked = false;
                        likes--;
                      });
                    } else {
                      await DatabaseService(uid: auth).addLike(widget.post.id, widget.type);
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
                            height: 550,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              color: white.shade50,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: white.shade50,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextField(
                                              onChanged: (value) {
                                                commentText = value;
                                              },
                                              decoration: textInputDecoration.copyWith(hintText: "Add your two cents"),
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              controller: commentController)),
                                      const SizedBox(width: 12),
                                      IconButton(
                                          style: ButtonStyle(
                                              padding: const MaterialStatePropertyAll(EdgeInsets.all(13)),
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                              backgroundColor: commentText.isNotEmpty
                                                  ? MaterialStatePropertyAll(purple.shade400)
                                                  : const MaterialStatePropertyAll(Colors.transparent)),
                                          onPressed: () => addComment(),
                                          icon: Icon(Ionicons.send,
                                              size: 16, color: commentText.isNotEmpty ? white.shade50 : white.shade700))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    key: ValueKey(comments.length),
                                    padding: const EdgeInsets.all(20),
                                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      Comment comment = comments[index];
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
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(color: white.shade700))
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
                                )
                              ],
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
