import "dart:io";

import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:image_picker/image_picker.dart";
import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";
import "package:unbound/common/buttons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/user.model.dart";
import "package:unbound/service/database.dart";

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String text = "";
  List<String> links = <String>[];
  XFile? image;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);
    UserData? userData = Provider.of<UserData?>(context);
    final router = GoRouter.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Create Post",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12.0),
                    Text("Post Body", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: "Write a body for your post!"),
                      validator: (val) => val != null && val.isEmpty ? 'Please fill this out.' : null,
                      style: Theme.of(context).textTheme.bodyLarge,
                      onChanged: (val) => text = val,
                      maxLength: 250,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      minLines: 3,
                      maxLines: 6,
                    ),
                    Text("Links", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6),
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: links.length,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                        itemBuilder: (BuildContext context, int index) => LinksTextField(
                            key: UniqueKey(),
                            initialValue: links[index],
                            onChanged: (v) {
                              links[index] = v;
                            },
                            remove: () {
                              setState(() {
                                links.removeAt(index);
                              });
                            })),
                    const SizedBox(height: 12),
                    if (links.length < 3)
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
                                  if (links.length < 3) {
                                    links.add("");
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
                    Text("Cover Image", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700)),
                    const SizedBox(height: 6.0),
                    FilledButton(
                      style: darkExpand,
                      onPressed: () async {
                        final imagePicker = ImagePicker();
                        XFile? nImage = (await imagePicker.pickImage(source: ImageSource.gallery));
                        if (nImage != null) {
                          setState(() => image = nImage);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.image,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Upload",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: white.shade100,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    if (image != null) Image.file(File(image!.path), height: 176.0)
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: FilledButton(
                style: lightExpand,
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (user?.uid != null) {
                      router.go('/feed');
                    }
                  }
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
                      "Discard",
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
                  if (_formKey.currentState?.validate() ?? false) {
                    if (user?.uid != null) {
                      await DatabaseService(uid: user!.uid).uploadPost(userData!, user.uid, text, links, image);
                      router.go('/feed');
                    }
                  }
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
                      "Post",
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

class LinksTextField extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;
  final void Function() remove;
  const LinksTextField({super.key, this.initialValue, required this.onChanged, required this.remove});

  @override
  State<LinksTextField> createState() => _LinksTextFieldState();
}

class _LinksTextFieldState extends State<LinksTextField> {
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
          hintText: "https://link.com",
          suffixIcon: IconButton(onPressed: widget.remove, icon: Icon(Ionicons.close, size: 16, color: white.shade700))),
      style: Theme.of(context).textTheme.bodyLarge,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return "No empty interests!";
        return null;
      },
    );
  }
}
