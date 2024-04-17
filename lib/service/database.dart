import 'package:cloud_firestore/cloud_firestore.dart';
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
      print('errored');
      print(e.toString());
      return null;
    }
  }
}
