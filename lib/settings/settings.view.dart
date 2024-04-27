import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/user.model.dart';
import 'package:unbound/service/auth.dart';
import 'package:unbound/views/loading.view.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLoading = false;
  Timer? t;

  @override
  Widget build(BuildContext context) {
    //UserData? user = Provider.of<UserData?>(context);
    if (!isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: white.shade50,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          titleSpacing: 0,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text("Settings", style: Theme.of(context).textTheme.displaySmall),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLoading = true;
                    t = Timer(const Duration(seconds: 2), () {
                      setState(() => isLoading = false);
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: white.shade300,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        const Icon(
                          Ionicons.lock_closed,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Forgot Password",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(dividerColor: white.shade300),
                child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Row(
                      children: [
                        Icon(
                          Ionicons.document_lock,
                          size: 18,
                          color: white.shade900,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text("Copyright", style: Theme.of(context).textTheme.bodyLarge)
                      ],
                    ),
                    children: [
                      Text(
                          "We assure that all work in this project is our own. We did not utilize any previously existing framework to build this, instead building it from scratch.",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 20)
                    ]),
              ),
              GestureDetector(
                onTap: () {
                  AuthService().signOut();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: white.shade300,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        const Icon(
                          Ionicons.exit,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Log Out",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const Loading();
  }
}
