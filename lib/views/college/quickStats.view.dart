import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';
import 'package:unbound/views/college/stat.widget.dart';

class QuickStats extends StatelessWidget {
  final List<Stat> livingStats;
  final Diversity diversity;
  const QuickStats({super.key, required this.diversity, required this.livingStats});

  @override
  Widget build(BuildContext context) {
    Widget legendItem(Color color, String text) {
      return Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: color)),
        const SizedBox(width: 6),
        Text(text, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700))
      ]);
    }

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top:  16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: white.shade300)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quick Stats", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white.shade900)),
              Icon(Ionicons.library, size: 24, color: blue.shade600)
          ]),
          const SizedBox(height: 12),
          createStatsRow(livingStats),
          const SizedBox(height: 12),
          Text("Diversity", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white.shade800)),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Expanded(flex: (diversity.white * 100).round(), child:  Container(height: 8, color: blue.shade700)),
                const SizedBox(width: 1),
                Expanded(flex: (diversity.black * 100).round(), child:  Container(height: 8, color: blue.shade600)),
                const SizedBox(width: 1),
                Expanded(flex: (diversity.hispanic * 100).round(), child:  Container(height: 8, color: blue.shade500)),
                const SizedBox(width: 1),
                Expanded(flex: (diversity.asian * 100).round(), child:  Container(height: 8, color: blue.shade400)),
                const SizedBox(width: 1),
                Expanded(flex: (diversity.native * 100).round(), child:  Container(height: 8, color: blue.shade300)),
                const SizedBox(width: 1),
                Expanded(flex: (diversity.other * 100).round(), child:  Container(height: 8, color: blue.shade200)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                legendItem(blue.shade700, "White"),
                legendItem(blue.shade600, "Black"),
                legendItem(blue.shade500, "Hispanic/Latino")
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  legendItem(blue.shade400, "Asia/Pacific Islander"),
                  legendItem(blue.shade300, "Native American/Alaskan Native"),
                  legendItem(blue.shade200, "Other")
                ],
              )
            ],
          )
        ],
      )
    );
  }
}