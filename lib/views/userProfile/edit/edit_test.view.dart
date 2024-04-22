import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";

class EditTest extends StatefulWidget {
  final TestScore old;

  const EditTest({super.key, required this.old});

  @override
  State<EditTest> createState() => _EditTestState();
}

class _EditTestState extends State<EditTest> {
  String name = "";
  String score = "";
  List<String> subcategories = <String>[""];
  List<String> scores = <String>[""];
  late final TestScore old;

  @override
  void initState() {
    super.initState();
    old = widget.old;
    name = old.name;
    score = old.score;
    subcategories = old.sectionScores.keys.toList();
    scores = old.sectionScores.cast<String, String>().values.toList();
  }

  String error = "";

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
                "Edit Standardized Test",
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
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Test Name",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700),
                      ),
                      const SizedBox(height: 6.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "SAT"),
                        validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                        onChanged: (val) => name = val,
                        style: Theme.of(context).textTheme.bodyLarge,
                        initialValue: old.name,
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
                      Text(
                        "Score",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700),
                      ),
                      const SizedBox(height: 6.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "1580"),
                        validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                        onChanged: (val) => score = val,
                        style: Theme.of(context).textTheme.bodyLarge,
                        initialValue: old.score,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sub Category", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                      const SizedBox(height: 6.0),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: subcategories.length,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                        itemBuilder: (BuildContext context, int index) => SubcategoryTextField(
                          key: UniqueKey(),
                          initialValue: subcategories[index],
                          onChanged: (v) {
                            subcategories[index] = v;
                          },
                          remove: () {
                            setState(
                              () {
                                subcategories.removeAt(index);
                                scores.removeAt(index);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Score", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                      const SizedBox(height: 6.0),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: scores.length,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                        itemBuilder: (BuildContext context, int index) => ScoreField(
                          key: UniqueKey(),
                          initialValue: scores[index],
                          onChanged: (v) {
                            scores[index] = v;
                          },
                          remove: () {
                            setState(
                              () {
                                subcategories.removeAt(index);
                                scores.removeAt(index);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            DottedBorder(
              color: white.shade700,
              borderType: BorderType.RRect,
              radius: const Radius.circular(8.0),
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (scores.length < 3) {
                          scores.add("");
                          subcategories.add("");
                          setState(() => {});
                        }
                      },
                      style: textExpand,
                      child: Text(
                        "+ Add",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: white.shade700,
                            ),
                      ),
                    ),
                  ),
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
                  Map<String, dynamic> m = {};
                  for (int i = 0; i < subcategories.length; i++) {
                    if (name.isEmpty || score.isEmpty || subcategories[i].isEmpty || scores[i].isEmpty) {
                      setState(() => error = "No empty fields");
                      return;
                    } else if (m.keys.contains(subcategories[i])) {
                      setState(() => error = "No duplicate keys");
                      return;
                    }
                    m[subcategories[i]] = scores[i];
                  }
                  await DatabaseService(uid: user.uid).deleteObject("tests", old.toJson());
                  await DatabaseService(uid: user.uid).addObject("tests", {
                    "name": name,
                    "score": score,
                    "sectionScores": m,
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

class SubcategoryTextField extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;
  final void Function() remove;
  const SubcategoryTextField({super.key, this.initialValue, required this.onChanged, required this.remove});

  @override
  State<SubcategoryTextField> createState() => _SubcategoryTextFieldState();
}

class _SubcategoryTextFieldState extends State<SubcategoryTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialValue ?? "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: textInputDecoration.copyWith(
          hintText: "Math",
          suffixIcon: IconButton(onPressed: widget.remove, icon: Icon(Ionicons.close, size: 16, color: white.shade700))),
      style: Theme.of(context).textTheme.bodyLarge,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return "No empty interests!";
        return null;
      },
    );
  }
}

class ScoreField extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;
  final void Function() remove;
  const ScoreField({super.key, this.initialValue, required this.onChanged, required this.remove});

  @override
  State<ScoreField> createState() => _ScoreFieldState();
}

class _ScoreFieldState extends State<ScoreField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialValue ?? "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: textInputDecoration.copyWith(
          hintText: "800",
          suffixIcon: IconButton(onPressed: widget.remove, icon: Icon(Ionicons.close, size: 16, color: white.shade700))),
      style: Theme.of(context).textTheme.bodyLarge,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return "No empty interests!";
        return null;
      },
    );
  }
}
