import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';

class ViewReviews extends StatelessWidget {
  final List<Review> reviews;
  const ViewReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    Widget buildStars(int count) {
      return Row(
        children: [
          for (int i = 0; i < count; i++)
            Icon(Ionicons.star, color: yellow.shade400, size: 14,),
          for(int i = count; i < 5; i++) Icon(Ionicons.star_outline, color: yellow.shade400, size: 14,)
        ],
      );
    }

    Widget buildReview(Review r) {
      return Container(
        width: 250,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: white.shade50,
          border: Border.all(color: white.shade300),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: white.shade500.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4))]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: white.shade400,
                  backgroundImage: NetworkImage(r.photo),
                  radius: 15,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.name, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade900)),
                      Text(r.classOf, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: yellow.shade500))
                    ],
                  ),
                ),
                buildStars(r.stars)
              ],
            ),
            const SizedBox(height: 12),
            Text(r.text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white.shade700))
          ],
        ),
      );
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reviews",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: white.shade900)),
                Icon(Ionicons.sparkles, size: 24, color: yellow.shade500)
              ],
            )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 20),
              ...reviews.map((e) => buildReview(e)),
              const SizedBox(width: 8)
            ],
          ),
        )
      ],
    );
  }
}
