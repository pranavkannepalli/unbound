import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unbound/model/user.model.dart';

class DatabaseService {
  final String? uid;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Users");

  DatabaseService({this.uid});

  Future updateUserData(Map<String, dynamic> json) async {
    return await usersCollection.doc(uid).set(json, SetOptions(merge: true));
  }

  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      Map<String, dynamic> d = snapshot.data() as Map<String, dynamic>;
      UserData ret = UserData.fromJson(d);

      return ret;
    } catch (error) {
      print('errored');
      return null;
    }
  }

  Stream<UserData?> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<UserData?> getData() async {
    return usersCollection.doc(uid).get().then((value) => _userDataFromSnapshot(value));
  }
}
