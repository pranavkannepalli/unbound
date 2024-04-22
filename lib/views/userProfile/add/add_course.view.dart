import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  String name = "";
  String years = "";
  String description = "";
  String score = "";

  String error = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser>(context);
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
                "Add Course",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                            const SizedBox(height: 6.0),
                            TextFormField(
                              initialValue: "",
                              decoration: textInputDecoration.copyWith(hintText: "AP Computer Science A"),
                              validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                              onChanged: (val) => name = val,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Score", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                            const SizedBox(height: 6.0),
                            TextFormField(
                              initialValue: "",
                              decoration: textInputDecoration.copyWith(hintText: "A+"),
                              validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                              onChanged: (val) => score = val,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text("Time Period", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                  const SizedBox(height: 6.0),
                  TextFormField(
                    initialValue: "",
                    decoration: textInputDecoration.copyWith(hintText: "2021 - 2023"),
                    validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                    onChanged: (val) => years = val,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12.0),
                  Text("Description", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                  const SizedBox(height: 6.0),
                  TextFormField(
                    initialValue: "",
                    decoration: textInputDecoration.copyWith(hintText: "Tell us about this course"),
                    validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                    onChanged: (val) => description = val,
                    maxLines: 8,
                    minLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              error,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: pink.shade500,
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: FilledButton(
                style: lightExpand,
                onPressed: () async {
                  GoRouter.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.trash_bin,
                      color: white.shade800,
                      size: 18,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                style: darkExpand,
                onPressed: () async {
                  await DatabaseService(uid: user.uid).addObject("coursework", {
                    "name": name,
                    "score": score,
                    "description": description,
                    "years": years,
                  });
                  GoRouter.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Ionicons.arrow_up,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "Save",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
