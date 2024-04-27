import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unbound/common/theme.dart';
import 'package:unbound/model/company.model.dart';
import 'package:unbound/service/database.dart';
import 'package:unbound/views/company/internships.widget.dart';
import 'package:unbound/views/company/news.widget.dart';

class CompanyProfile extends StatefulWidget {
  final String uid;
  const CompanyProfile({super.key, required this.uid});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          DatabaseService(uid: widget.uid).getCompanyData(widget.uid),
          DatabaseService(uid: widget.uid).getCompanyNews(widget.uid)
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List<dynamic>? data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            Company company = data[0];
            News news = data[1];

            return Scaffold(
              extendBodyBehindAppBar: true,
              body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: white.shade50,
                        expandedHeight: 600,
                        collapsedHeight: 600,
                        flexibleSpace: Column(
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  color: white.shade200,
                                  margin: const EdgeInsets.only(bottom: 50),
                                  child: company.bgImg.isNotEmpty
                                      ? Image.network(company.bgImg, width: double.infinity, height: 250, fit: BoxFit.cover)
                                      : const SizedBox(width: double.infinity, height: 250),
                                ),
                                Positioned(
                                  top: 200,
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(company.photo),
                                    backgroundColor: white.shade400,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(company.name, style: Theme.of(context).textTheme.displaySmall),
                                  Text("Founded in ${company.founded} @ ${company.location}",
                                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: white.shade700)),
                                  const SizedBox(height: 6),
                                  Text(company.description,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: white.shade700)),
                                  const SizedBox(height: 6),
                                  TabBar(
                                    controller: controller,
                                    overlayColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return white.shade300;
                                      }
                                      return Colors.transparent;
                                    }),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicatorColor: white.shade900,
                                    indicatorWeight: 2,
                                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                                    tabs: const [
                                      Tab(
                                        text: "Jobs",
                                      ),
                                      Tab(
                                        text: "News",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: controller,
                    children: [SingleChildScrollView(child: Internships(jobs: company.internships)), NewsWidget(news: news)],
                  )),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
