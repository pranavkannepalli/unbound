import "package:flutter/material.dart";
import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserData? userData = Provider.of<UserData?>(context);
    const gap = SizedBox(height: 6.0);

    createKVPair(title, data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title:", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
            Text(data.toString()),
            gap
          ],
        );

    createInterests() {
      List<Widget> ints = [];
      if (userData?.interests != null) {
        final textColor = [blue.shade800, green.shade500, pink.shade500];
        final bgColor = [blue.shade400, green.shade300, pink.shade300];

        for (int i = 0; i < userData!.interests!.length; i++) {
          Widget n = Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              color: bgColor.elementAt(i % bgColor.length),
            ),
            child: Text(userData.interests!.elementAt(i),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor.elementAt(i % textColor.length))),
          );

          ints.add(n);
        }
      }
      return ints;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),
        Center(
          child: CircleAvatar(
            backgroundColor: white.shade300,
            backgroundImage: NetworkImage(userData!.photo!),
            radius: 60,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(width: 1.0, color: white.shade300),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text("Basic Info", style: Theme.of(context).textTheme.displaySmall),
                  ),
                  IconButton(
                    icon: Icon(
                      Ionicons.pencil,
                      color: blue.shade600,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              createKVPair("Name", userData.name!),
              createKVPair("Grad Year", userData.grad!),
              createKVPair("School", userData.school!),
              createKVPair("Bio", userData.bio!),
              Wrap(
                spacing: 12.0,
                runSpacing: 6.0,
                children: createInterests(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(width: 1.0, color: white.shade300),
            ),
          ),
          child: Text("${userData.name}'s Next Section"),
        ),
      ],
    );
  }
}
