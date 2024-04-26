import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unbound/model/company.model.dart';
import 'package:unbound/model/feed.model.dart';
import 'package:unbound/model/user.model.dart';
import "package:unbound/model/college.model.dart";

class DatabaseService {
  final String? uid;
  final CollectionReference collegesCollection = FirebaseFirestore.instance.collection("Colleges");
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Users");
  final CollectionReference companiesCollection = FirebaseFirestore.instance.collection("Companies");
  final CollectionReference collegePostCollection = FirebaseFirestore.instance.collection("CollegePosts");
  final CollectionReference companyPostCollection = FirebaseFirestore.instance.collection("InternshipPosts");
  final CollectionReference userPostCollection = FirebaseFirestore.instance.collection("UserPosts");
  final CollectionReference tweetsCollection = FirebaseFirestore.instance.collection("Twitter");
  static final defaultUser = {
    "name": "",
    "email": "",
    "grad": 2025,
    "state": "WA",
    "school": "Tesla STEM High School",
    "interests": ["Computer Science", "Flutter", "Firebase"],
    "photo": "",
    "bio": "I love flutter, computer science, and mobile app development. :)",
    "bday": "2007-02-26 00:00:00.000",
    "posts": [],
    "tests": [
      TestScore(
        name: "SAT",
        score: "1580",
        sectionScores: {"Math": "800", "English": "780"},
      ).toJson(),
    ],
    "coursework": [
      Course(
        name: "AP Computer Science A",
        description: "A CS Class that taught me a lot about computer science principles and Java.",
        score: "5",
        years: "2022 - 2023",
      ).toJson()
    ],
    "clubs": [
      Club(
        accomplishments: [
          Accomplishment(
            name: "Webmaster",
            place: "1",
            location: "TSA Nationals",
            year: "2023",
            link: "",
            description: "First in the nation in the Webmaster event at TSA Nationals.",
          ),
        ],
        roles: [
          Role(
            name: "President",
            description: "President of Tesla STEM TSA for one year",
            years: "2023 - 2024",
          ),
        ],
        photo: "",
        name: "Technology Student Association",
        years: "2023 - 2024",
      ).toJson()
    ],
    "arts": [
      Art(
        name: "Tabla",
        years: "2016 - 2024",
        description: "Played this Indian Drum for many years, while passing the first and second accredited exams.",
        photos: [
          "https://images.unsplash.com/photo-1568219656418-15c329312bf1?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "https://images.unsplash.com/photo-1633411988188-6e63354a9019?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dGFibGF8ZW58MHx8MHx8fDA%3D",
        ],
        accomplishments: [
          Accomplishment(
            name: "Raag Sandhana",
            place: "9",
            location: "Online",
            year: "2023",
            link: "",
            description: "Ninth among hundreds of competitors in the classical tabla section after a video submission.",
          ),
        ],
      ).toJson(),
    ],
    "sports": [
      Sport(
        name: "Cricket",
        years: "2016 - 2024",
        position: "All-Rounder",
        photos: [],
        accomplishments: [
          Accomplishment(
            name: "MLC Jr Championships",
            place: "9",
            location: "Houston, TX",
            year: "2023",
            link: "",
            description: "We were the best team in the nation at this competition and won a National Trophy.",
          ),
        ],
        stats: {
          "Matches": "150",
          "Batting Average": "43",
          "Runs": (43 * 150).toString(),
          "Bowling Average": "14",
          "Wickets": "100",
        },
      ).toJson(),
    ],
    "work": [
      Work(
        name: "ML Workflow Intern",
        years: "2023",
        photo:
            "https://images.unsplash.com/photo-1633419461186-7d40a38105ec?q=80&w=3280&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        description: "An internship with People Tech Group that involved ML Workflow maintenance.",
      ).toJson(),
    ],
    "projects": [
      Project(
        name: "SpaceOasis",
        photos: [],
        years: "2023",
        skills: ["NextJS", "ReactJS", "Firebase"],
        description: "The website project that won first at TSA Nationals in Kentucky in 2023.",
      ).toJson(),
    ],
    "following": [],
    "colleges": [],
  };

  DatabaseService({this.uid});

  Future updateUserData(Map<String, dynamic> json) async {
    return await usersCollection.doc(uid).set(json, SetOptions(merge: true));
  }

  Stream<UserData?> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<List<List<Account>>> getUsers(String name) async {
    final users = await usersCollection
        .where('name', isNotEqualTo: name)
        .get()
        .then((value) => value.docs.map((doc) => _accountFromSnapshot(doc)).toList());
    final companies =
        await companiesCollection.get().then((value) => value.docs.map((doc) => _accountFromSnapshot(doc)).toList());
    final colleges = await collegesCollection.get().then((value) => value.docs.map((doc) => _accountFromSnapshot(doc)).toList());

    return [colleges, users, companies];
  }

  Future<List<Post>> getUserPosts() async {
    final postsData = await userPostCollection.where("uid", isEqualTo: uid).get();
    return postsData.docs.map((e) => _postFromSnapshot(e)).toList();
  }

  Future<News> getCompanyNews(String companyId) async {
    List<Future<QuerySnapshot>> futures = [];
    final postsFuture = companyPostCollection.where("uid", isEqualTo: companyId).get();
    final tweetsFuture = tweetsCollection.where("uid", isEqualTo: companyId).get();

    futures.add(postsFuture);
    futures.add(tweetsFuture);
    List<QuerySnapshot> results = await Future.wait(futures);
    List<Post> posts = results.elementAt(0).docs.map((e) {
      return _postFromSnapshot(e);
    }).toList();
    List<Tweet> tweets = results.elementAt(1).docs.map((e) => _tweetFromSnapshot(e)).toList();
    print(tweets.length);
    return News(tweets: tweets, posts: posts);
  }

  Future<College> getCollegeData(String id) async {
    final snapshot = await collegesCollection.doc(id).get();
    final collegeData = snapshot.data() as Map<String, dynamic>;
    collegeData["id"] = snapshot.id;
    return College.fromJSON(collegeData);
  }

  Future<List<Post>> getCollegePosts(String collegeId) async {
    final snapshot = await collegePostCollection.where("uid", isEqualTo: collegeId).get();
    return snapshot.docs.map((e) => _postFromSnapshot(e)).toList();
  }

  Future<Company> getCompanyData(String id) async {
    final snapshot = await companiesCollection.doc(id).get();
    final companyData = snapshot.data() as Map<String, dynamic>;
    return Company.fromJSON(companyData);
  }

  Future<UserData?> getData() async {
    try {
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
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Feed>?> getFeeds(String name, List<String> following) async {
    // Return three feeds: college, people, companies
    try {
      final collegePostQuery = await collegePostCollection.orderBy("time", descending: true).get();
      final collegePostData = collegePostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();
      collegePostData.shuffle();
      final colleges = await collegesCollection.get();
      final collegesData = colleges.docs.map((e) => _accountFromSnapshot(e)).toList();
      collegesData.shuffle();

      final collegeFeed = Feed(posts: collegePostData.take(5).toList(), recommended: collegesData.take(5).toList());
      final userPostQuery = await userPostCollection.orderBy("time", descending: true).get();
      final userPostData = userPostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final usersQuery = await usersCollection.where('name', isNotEqualTo: name).get();
      final usersData =
          usersQuery.docs.where((doc) => !following.contains(doc.id)).map((doc) => _accountFromSnapshot(doc)).toList();
      usersData.shuffle();

      final userFeed = Feed(posts: userPostData.take(5).toList(), recommended: usersData.take(5).toList());

      final companyPostQuery = await companyPostCollection.orderBy("time", descending: true).get();
      final companyPostData = companyPostQuery.docs.map((doc) => _postFromSnapshot(doc)).toList();

      final companiesQuery = await companiesCollection.get();
      final companiesData = companiesQuery.docs.map((doc) => _accountFromSnapshot(doc)).toList();
      companiesData.shuffle();

      final companyFeed = Feed(posts: companyPostData.take(5).toList(), recommended: companiesData.take(5).toList());

      return [collegeFeed, userFeed, companyFeed];
    } catch (e) {
      return null;
    }
  }

  Future followAccount(String id) async {
    await usersCollection.doc(uid).update({
      "following": FieldValue.arrayUnion([id])
    });
  }

  Future unfollowAccount(String id) async {
    await usersCollection.doc(uid).update({
      "following": FieldValue.arrayRemove([id])
    });
  }

  Future addObject(String section, Map<String, dynamic> json) async {
    await usersCollection.doc(uid).update({
      section: FieldValue.arrayUnion([json])
    });
  }

  Future addComment(String postUid, String uid, String postType, Comment comment) async {
    try {
      switch (postType) {
        case "Student":
          await userPostCollection.doc(postUid).update({
            "comments": FieldValue.arrayUnion(
              [comment.toJSON()],
            )
          });
        case "Company":
          await companyPostCollection.doc(postUid).update({
            "comments": FieldValue.arrayUnion(
              [comment.toJSON()],
            )
          });
        case "College":
          await collegePostCollection.doc(postUid).update({
            "comments": FieldValue.arrayUnion(
              [comment.toJSON()],
            )
          });
      }
    } catch (e) {
      print(e.toString());
    }
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
      // do something here
    }
  }

  Future addLike(String postUid, String postType) async {
    print(postUid);
    print(postType);
    try {
      switch (postType) {
        case ("College"):
          await collegePostCollection.doc(postUid).update({
            "likes": FieldValue.arrayUnion([uid])
          });
          break;
        case ("Student"):
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
      //Error
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

  Future changePfp(XFile file) async {
    try {
      final time = Timestamp.now();
      final reference = FirebaseStorage.instance.ref().child('/images/$uid$time');
      await reference.putFile(File(file.path));
      String imageUrl = await reference.getDownloadURL();

      updateUserData({"photo": imageUrl});
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadPost(UserData data, String text, List<String> links, XFile? file) async {
    try {
      if (file != null) {
        final time = Timestamp.now();
        final reference = FirebaseStorage.instance.ref().child('/images/$uid$time');
        await reference.putFile(File(file.path));
        String imageUrl = await reference.getDownloadURL();

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

        List<String>? posts = data.posts;
        posts.add(doc.id);
        updateUserData({"posts": posts});
      } else {
        final time = Timestamp.now();

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

        List<String>? posts = data.posts;
        posts.add(doc.id);
        updateUserData({"posts": posts});
      }
    } catch (e) {
      print(e);
    }
  }

  Tweet _tweetFromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> d = snapshot.data() as Map<String, dynamic>;
    return Tweet.fromJSON(d);
  }

  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      Map<String, dynamic> d = snapshot.data() as Map<String, dynamic>;
      UserData ret = UserData.fromJson(d);

      return ret;
    } catch (error) {
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
