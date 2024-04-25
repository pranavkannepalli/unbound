import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";
import "package:unbound/views/onboarding/onboarding3.view.dart";

class EditBasicInfo extends StatefulWidget {
  final UserData old;

  const EditBasicInfo({super.key, required this.old});

  @override
  State<EditBasicInfo> createState() => _EditBasicInfoState();
}

class _EditBasicInfoState extends State<EditBasicInfo> {
  String fname = "";
  String lname = "";
  String grad = "";
  String school = "";
  String state = "";
  String bio = "";
  List<String> interests = [];

  @override
  void initState() {
    super.initState();
    fname = widget.old.name.split(" ")[0];
    lname = widget.old.name.split(" ")[1];
    grad = widget.old.grad.toString();
    school = widget.old.school;
    bio = widget.old.bio;
    interests = widget.old.interests;
    state = widget.old.state;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);
    UserData? userData = Provider.of<UserData?>(context);
    final router = GoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white.shade50,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: Icon(
                  Ionicons.chevron_back,
                  color: white.shade700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: Text(
                "Edit Basic Info",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                              const SizedBox(height: 6),
                              TextFormField(
                                initialValue: fname,
                                decoration: textInputDecoration.copyWith(hintText: "John"),
                                validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                onChanged: (val) => fname = val,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Last Name", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                              const SizedBox(height: 6),
                              TextFormField(
                                initialValue: lname,
                                decoration: textInputDecoration.copyWith(hintText: "Doe"),
                                validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                onChanged: (val) => lname = val,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text("School", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    TextFormField(
                      initialValue: school,
                      decoration: textInputDecoration.copyWith(hintText: "2025"),
                      validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                      onChanged: (val) => school = val,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Graduation Year",
                                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                              const SizedBox(height: 6),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: grad,
                                decoration: textInputDecoration.copyWith(hintText: "2025"),
                                validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                onChanged: (val) => grad = val,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                              const SizedBox(height: 6.0),
                              TextFormField(
                                  initialValue: state,
                                  decoration: textInputDecoration.copyWith(hintText: "WA"),
                                  validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                                  onChanged: (val) => state = val,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text("Bio (250 words)", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      initialValue: userData?.bio ?? "",
                      decoration: textInputDecoration.copyWith(hintText: "Tell us about yourself"),
                      validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                      onChanged: (val) => bio = val,
                      maxLines: 8,
                      minLines: 2,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                    Text("Interests (Add 3)", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: interests.length,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                        itemBuilder: (BuildContext context, int index) => InterestTextField(
                            key: UniqueKey(),
                            initialValue: interests[index],
                            onChanged: (v) {
                              interests[index] = v;
                            },
                            remove: () {
                              setState(() {
                                interests.removeAt(index);
                              });
                            })),
                    const SizedBox(height: 12),
                    if (interests.length < 3)
                      FilledButton(
                        onPressed: () {
                          if (interests.length < 3) {
                            interests.add("");
                            setState(() => {});
                          }
                        },
                        style: lightExpand,
                        child: Text(
                          "Add Interest",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: const Color(0xFF4C4C4C),
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    style: lightExpand,
                    onPressed: () async {
                      print({
                        "name": "$fname $lname",
                        "grad": grad,
                        "school": school,
                        "bio": bio,
                        "state": state,
                        "interests": interests,
                      });
                      router.pop();
                    },
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: white.shade800,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    style: darkExpand,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (user?.uid != null) {
                          await DatabaseService(uid: user!.uid).updateUserData({
                            "name": "$fname $lname",
                            "grad": int.parse(grad),
                            "school": school,
                            "bio": bio,
                            "state": state,
                            "interests": interests,
                          });
                          router.pop();
                        }
                      }
                    },
                    child: Text(
                      "Continue",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: const Color(0xFFFFFFFF),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
