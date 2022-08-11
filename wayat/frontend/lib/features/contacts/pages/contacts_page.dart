import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: AutoTabsRouter.tabBar(
          routes: [FriendsRoute(), RequestsRoute(), SuggestionsRoute()],
          builder: ((context, child, tabController) {
            return Column(
              children: [_tabBar(tabController), Expanded(child: child)],
            );
          }),
        ))
      ],
    );
  }

  Widget _tabBar(TabController tabController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          _indicatorBackground(),
          TabBar(
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black45),
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              indicatorPadding: const EdgeInsets.only(top: 45),
              indicator: _tabIndicator(),
              labelColor: Colors.black87,
              controller: tabController,
              tabs: const [
                Tab(text: "Friends"),
                Tab(text: "Requests"),
                Tab(text: "Suggestions")
              ]),
        ],
      ),
    );
  }

  Decoration _tabIndicator() {
    return const ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.black);
  }

  Widget _indicatorBackground() {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      height: 4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromARGB(255, 222, 228, 255),
      ),
    );
  }
}
