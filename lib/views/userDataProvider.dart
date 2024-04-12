import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/database.dart';

class UserProvider extends StatelessWidget {
  const UserProvider({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser?>(context);

    return StreamProvider.value(
      initialData: null,
      value: DatabaseService(uid: user?.uid).userData,
      child: child,
    );
  }
}
