import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/model/user.model.dart';

class DatabaseService {
  final String? uid;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Users");
  final CollectionReference companiesCollection = FirebaseFirestore.instance.collection("Companies");
  final CollectionReference collegePostCollection = FirebaseFirestore.instance.collection("CollegePosts");
  final CollectionReference companyPostCollection = FirebaseFirestore.instance.collection("CompanyPosts");
  final CollectionReference userPostCollection = FirebaseFirestore.instance.collection("UserPosts");
  static final defaultUser = {
    "name": "",
    "email": "",
    "grad": -1,
    "state": "",
    "school": "",
    "interests": [],
    "photo": "",
    "bio": "",
    "bday": "",
    "posts": [],
    "tests": [],
    "coursework": [],
    "clubs": [],
    "arts": [],
    "sports": [],
    "work": [],
    "projects": [],
    "colleges": [],
  };

  DatabaseService({this.uid});

  Future updateUserData(Map<String, dynamic> json) async {
    return await usersCollection.doc(uid).set(json, SetOptions(merge: true));
  }

  Stream<UserData?> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<List<List<Account>>> getUsers() async {
    final users = await usersCollection.get().then((value) => value.docs.map((doc) => _accountFromSnapshot(doc)).toList());
    final companies =
        await companiesCollection.get().then((value) => value.docs.map((doc) => _accountFromSnapshot(doc)).toList());

    return [[], users, companies];
  }

  Future<UserData?> getData() async {
    final snapshot = await usersCollection.doc(uid).get();
    final userData = snapshot.data() as Map<String, dynamic>;

    var pushData = <String, dynamic>{};
    var needsPush = false;

    for (var key in defaultUser.keys) {
      if (!userData.containsKey(key)) {
        pushData[key] = defaultUser[key];
        userData[key] = defaultUser[key];
        needsPush = true;
      }
    }

    if (needsPush) {
      await updateUserData(pushData);
    }

    return UserData.fromJson(userData);
  }

  // TODO: build fetching for companies and colleges

  Future<List<Feed>?> getFeeds() async {
    // Return three feeds: college, people, companies
    try {
      final collegePostQuery = await collegePostCollection.orderBy("time", descending: true).get();
      final collegePostData = collegePostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final collegeFeed = Feed(posts: collegePostData.take(5).toList(), recommended: []);

      final userPostQuery = await userPostCollection.orderBy("time", descending: true).get();
      final userPostData = userPostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final usersQuery = await usersCollection.get();
      final usersData = usersQuery.docs.map((doc) => _accountFromSnapshot(doc)).toList();

      final userFeed = Feed(posts: userPostData.take(5).toList(), recommended: usersData.take(5).toList());

      final companyPostQuery = await companyPostCollection.orderBy("time", descending: true).get();
      final companyPostData = companyPostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final companiesQuery = await companiesCollection.get();
      final companiesData = companiesQuery.docs.map((doc) => _accountFromSnapshot(doc)).toList();

      final companyFeed = Feed(posts: companyPostData.take(5).toList(), recommended: companiesData.take(5).toList());

      return [collegeFeed, userFeed, companyFeed];
    } catch (e) {
      return null;
    }
  }

  Future addObject(String section, Map<String, dynamic> json) async {
    await usersCollection.doc(uid).update({
      section: FieldValue.arrayUnion([json])
    });
  }

  Future deleteObject(String section, Map<String, dynamic> json) async {
    await usersCollection.doc(uid).update({
      section: FieldValue.arrayRemove([json])
    });
  }

  Future editObject(String section, Map<String, dynamic> userData, Map<String, dynamic> newJson, int index) async {
    try {
      var newData = userData[section] as List<Map<String, dynamic>>;
      newData[index] = newJson;
      await usersCollection.doc(uid).update({
        section: newData,
      });
    } catch (e) {
      print(e.toString());
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
        case ("Company"):
          await companyPostCollection.doc(postUid).update({
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
        case ("Company"):
          await companyPostCollection.doc(postUid).update({
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
          "likes": [],
          "comments": [],
          "time": time,
          "photo": imageUrl,
        };

        final doc = await userPostCollection.add(json);

        print('updating user data');
        List<String>? posts = data.posts;
        posts.add(doc.id);
        updateUserData({"posts": posts});
      } else {
        final time = Timestamp.now();

        print('uploading post data');
        Map<String, dynamic> json = {
          "author": data.name,
          "uid": uid,
          "pfp": data.photo,
          "text": text,
          "likes": [],
          "comments": [],
          "time": time,
          "photo": "",
        };

        final doc = await userPostCollection.add(json);

        print('updating user data');
        List<String>? posts = data.posts;
        posts.add(doc.id);
        updateUserData({"posts": posts});
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
    d["id"] = snapshot.id;
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
