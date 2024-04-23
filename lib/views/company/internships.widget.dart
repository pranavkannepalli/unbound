import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/buttons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/company.model.dart';

class Internships extends StatelessWidget {
  final List<Internship> jobs;
  const Internships({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Open Internships",
                  style: Theme.of(context).textTheme.displaySmall),
              Icon(Ionicons.briefcase, size: 24, color: blue.shade600)
            ],
          ),
          const SizedBox(height: 12),
          for (Internship i in jobs) Job(job: i)
        ],
      ),
    );
  }
}

class Job extends StatelessWidget {
  final Internship job;
  const Job({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final List<Benefit> details = [
      Benefit(icon: "cash", name: job.pay),
      Benefit(icon: "time", name: job.time),
      Benefit(icon: "ribbon", name: job.level)
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: white.shade50,
          border: Border.all(color: white.shade300, width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(job.name, style: Theme.of(context).textTheme.labelLarge),
          Text("${job.team} • ${job.location}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: blue.shade600)),
          const SizedBox(height: 6),
          Text(job.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: white.shade800)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (Benefit b in job.benefits) BenefitPair(benefit: b)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (Benefit b in details) BenefitPair(benefit: b)],
            )
          ]),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {},
              style: darkExpand,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Ionicons.enter, size: 18, color: white.shade50),
                  const SizedBox(width: 12),
                  Text("Apply",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: white.shade50))
                ],
              ))
        ],
      ),
    );
  }
}

class BenefitPair extends StatelessWidget {
  final Benefit benefit;
  const BenefitPair({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        children: [
          Icon(getIcon(benefit.icon), size: 14, color: white.shade700),
          const SizedBox(width: 6),
          Text(benefit.name,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: white.shade700))
        ],
      ),
    );
  }
}

IoniconsData getIcon(String name) {
  switch (name) {
    case "home":
      return Ionicons.home;
    case "fast-food":
      return Ionicons.fast_food;
    case "people":
      return Ionicons.people;
    case "cash":
      return Ionicons.cash;
    case "time":
      return Ionicons.time;
    case "ribbon":
      return Ionicons.ribbon;
    default:
      return Ionicons.close;
  }
}
