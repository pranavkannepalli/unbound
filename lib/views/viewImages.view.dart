import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;
  const ImageGallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.shade900.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(onPressed: () {
            GoRouter.of(context).pop();
          }, icon: Icon(Ionicons.close, size: 24, color: white.shade50))
        ],
        title: Text("Gallery", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white.shade50)),
      ),
      body: ListView.separated(itemBuilder:(context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.network(images[index], width: double.infinity),
        );
      }, separatorBuilder:(context, index) => const SizedBox(height: 20), itemCount: images.length)
    );
  }
}