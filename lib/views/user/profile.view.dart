import 'package:flutter/material.dart';
import 'package:unbound/service/database.dart';

class UserProfile extends StatelessWidget {
  final String uid;
  const UserProfile({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DatabaseService(uid: uid).getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
