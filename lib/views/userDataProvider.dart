import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';
import 'package:unbound/views/loading.view.dart';

class UserProvider extends StatelessWidget {
  const UserProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser?>(context);

    if (user == null) {
      return child;
    } else {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider.value(
              initialData: snapshot.data,
              value: DatabaseService(uid: user.uid).userData,
              child: child,
            );
          } else {
            return const Loading();
          }
        },
        future: DatabaseService(uid: user.uid).getData(),
      );
    }
  }
}
