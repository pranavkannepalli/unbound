import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/model/user.model.dart';

class DatabaseService {
  final String? uid;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Users");
  final CollectionReference collegePostCollection = FirebaseFirestore.instance.collection("CollegePosts");
  final CollectionReference internshipPostCollection = FirebaseFirestore.instance.collection("InternshipPosts");
  final CollectionReference userPostCollection = FirebaseFirestore.instance.collection("UserPosts");

  DatabaseService({this.uid});

  Future updateUserData(Map<String, dynamic> json) async {
    return await usersCollection.doc(uid).set(json, SetOptions(merge: true));
  }

  Stream<UserData?> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<UserData?> getData() async {
    return usersCollection.doc(uid).get().then((value) => _userDataFromSnapshot(value));
  }

  Future<List<Feed>?> getFeeds() async {
    // Return three feeds: college, people, internships
    try {
      final collegePostQuery = await collegePostCollection.orderBy("time", descending: true).get();
      final collegePostData = collegePostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final collegeFeed = Feed(posts: collegePostData, recommended: []);

      final userPostQuery = await userPostCollection.orderBy("time", descending: true).get();
      final userPostData = userPostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final usersQuery = await usersCollection.get();
      final usersData = usersQuery.docs.map((doc) => _accountFromSnapshot(doc)).toList();

      final userFeed = Feed(posts: userPostData, recommended: usersData);

      final internshipPostQuery = await internshipPostCollection.orderBy("time", descending: true).get();
      final internshipPostData = internshipPostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final internshipFeed = Feed(posts: internshipPostData, recommended: []);

      return [collegeFeed, userFeed, internshipFeed];
    } catch (e) {
      return null;
    }
  }

  Future addLike(String postUid, String postType) async {
    try {
      switch (postType) {
        case ("College"):
          await collegePostCollection.doc(postUid).update({
            "likes": FieldValue.arrayUnion([uid])
          });
          break;
        case ("User"):
          await userPostCollection.doc(postUid).update({
            "likes": FieldValue.arrayUnion([uid])
          });
          break;
        case ("Internship"):
          await internshipPostCollection.doc(postUid).update({
            "likes": FieldValue.arrayUnion([uid])
          });
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future removeLike(String postUid, String postType) async {
    try {
      switch (postType) {
        case ("College"):
          await collegePostCollection.doc(postUid).update({
            "likes": FieldValue.arrayRemove([uid])
          });
          break;
        case ("User"):
          await userPostCollection.doc(postUid).update({
            "likes": FieldValue.arrayRemove([uid])
          });
          break;
        case ("Internship"):
          await internshipPostCollection.doc(postUid).update({
            "likes": FieldValue.arrayRemove([uid])
          });
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadPost(UserData data, String text, List<String> links, XFile? file) async {
    try {
      if (file != null) {
        print('uploading file');
        final time = Timestamp.now();
        final reference = FirebaseStorage.instance.ref().child('/images/$uid$time');
        await reference.putFile(File(file.path));
        String imageUrl = await reference.getDownloadURL();

        print('uploading post data');
        Map<String, dynamic> json = {
          "author": data.name,
          "uid": uid,
          "pfp": data.photo,
          "text": text,
          "time": time,
          "likes": [],
          "comments": [],
          "photo": imageUrl,
        };

        final doc = await userPostCollection.add(json);

        print('updating user data');
        List<String>? posts = data.posts ?? [];
        posts.add(doc.id);
        DatabaseService(uid: uid).updateUserData({"posts": posts});
      }
    } catch (e) {
      print(e);
    }
  }

  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      Map<String, dynamic> d = snapshot.data() as Map<String, dynamic>;
      UserData ret = UserData.fromJson(d);

      print('User Data received: $ret');

      return ret;
    } catch (error) {
      print('errored');
      return null;
    }
  }

  Post _postFromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> d = snapshot.data() as Map<String, dynamic>;
    Post ret = Post.fromJSON(d);
    return ret;
  }

  Account _accountFromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> d = snapshot.data() as Map<String, dynamic>;
    d['uid'] = snapshot.id;
    Account ret = Account.fromJSON(d);

    return ret;
  }
}
