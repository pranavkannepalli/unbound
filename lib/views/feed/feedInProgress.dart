import 'package:flutter/material.dart';
import 'package:unbound/service/database.dart';
import 'package:unbound/views/inProgress.view.dart';
import 'package:unbound/views/loading.view.dart';

class FeedInProgress extends StatelessWidget {
  const FeedInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getFeeds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return const InProgressScreen();
        } else {
          return const Loading();
        }
      },
    );
  }
}
