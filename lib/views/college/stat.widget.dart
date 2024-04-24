import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/college.model.dart';

class StatWidget extends StatelessWidget {
  final Stat stat;
  const StatWidget({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white.shade200,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(getIcon(stat.name), color: white.shade800, size: 16),
              const SizedBox(width: 6),
              Text(stat.name, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: white.shade800)),
            ],
          ),
          const SizedBox(height: 6),
          Text(stat.statistic, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: white.shade800)),
          Text(stat.caption, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white.shade700))
        ],
      ),
    );
  }
}


Widget createStatsRow(List<Stat> stats) {
  return IntrinsicHeight(
    child: (
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: StatWidget(stat: stats.elementAt(0))),
          const SizedBox(width: 12),
          Expanded(child: StatWidget(stat: stats.elementAt(1))),
        ],
      )
    ),
  );
}


IoniconsData getIcon(String name) {
  switch(name) {
    case "Acceptance": return Ionicons.enter;
    case "Tuition": return Ionicons.cash;
    case "Class Sizes": return Ionicons.easel;
    case "Average SAT": return Ionicons.pie_chart;
    case "Average ACT": return Ionicons.medal;
    case "Average GPA": return Ionicons.stats_chart;
    case "Safety": return Ionicons.alert_circle;
    case "Location": return Ionicons.location;
    default: return Ionicons.close;
  }
}