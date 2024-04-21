import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:ionicons/ionicons.dart";
import "package:unbound/common/text_input.dart";
import "package:unbound/common/theme.dart";
import "package:unbound/model/feed.model.dart";
import "package:unbound/service/database.dart";

class Search extends StatefulWidget {
  final String initialQuery;

  const Search({super.key, required this.initialQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late TabController controller;
  String query = "";
  int currentIndex = 0;

  void handleTabChange() {
    setState(() {
      currentIndex = controller.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialQuery;
    query = widget.initialQuery;
    controller = TabController(length: 3, vsync: this);
    controller.addListener(handleTabChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white.shade50,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 20),
                child: TextField(
                  controller: _controller,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: textInputDecoration.copyWith(hintText: "Enter a Query"),
                  onSubmitted: (value) => setState(() => query = value),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(color: white.shade400, borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      color: white.shade50,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 8)]),
                  tabs: [
                    Tab(
                      height: 30,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(currentIndex == 0 ? Ionicons.library : Ionicons.library_outline,
                            size: 14, color: currentIndex == 0 ? purple.shade400 : white.shade700),
                        const SizedBox(width: 8),
                        Text("Colleges", style: Theme.of(context).textTheme.bodySmall)
                      ]),
                    ),
                    Tab(
                      height: 30,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(currentIndex == 1 ? Ionicons.people : Ionicons.people_outline,
                            size: 14, color: currentIndex == 1 ? green.shade400 : white.shade700),
                        const SizedBox(width: 8),
                        Text("People", style: Theme.of(context).textTheme.bodySmall)
                      ]),
                    ),
                    Tab(
                      height: 30,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(currentIndex == 2 ? Ionicons.briefcase : Ionicons.briefcase_outline,
                            size: 14, color: currentIndex == 2 ? blue.shade600 : white.shade700),
                        const SizedBox(width: 8),
                        Text("Companies", style: Theme.of(context).textTheme.bodySmall)
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.0),
              FutureBuilder(
                future: DatabaseService().getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<List<Account>>? data = snapshot.data;
                    List<Account> currentData = data![currentIndex];
                    return SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: currentData
                                .where((element) => element.name.contains(query))
                                .map((account) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 6.0),
                                        SearchAccount(
                                          account: account,
                                          type: currentIndex == 0 ? "college" : (currentIndex == 1 ? "user" : "company"),
                                        ),
                                      ],
                                    ))
                                .toList()));
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchAccount extends StatelessWidget {
  final Account account;
  final String type;

  const SearchAccount({
    super.key,
    required this.account,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    print(account);

    return TextButton(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: white.shade300,
            backgroundImage: NetworkImage(account.pfp),
            radius: 20.0,
          ),
          const SizedBox(width: 12.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(account.name, style: Theme.of(context).textTheme.titleMedium),
            ],
          )
        ],
      ),
      onPressed: () => GoRouter.of(context).push("/$type", extra: account.uid),
    );
  }
}
