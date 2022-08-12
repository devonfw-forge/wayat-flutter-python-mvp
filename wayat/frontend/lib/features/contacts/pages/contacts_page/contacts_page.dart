import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class ContactsPage extends StatelessWidget {
  final ContactsPageController controller =
      GetIt.I.get<ContactsPageController>();

  ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          controller: controller.searchBarController,
          onChanged: (text) => controller.setSearchBarText(text),
        ),
        contactsPageContent()
      ],
    );
  }

  Expanded contactsPageContent() {
    return Expanded(
        child: AutoTabsRouter.tabBar(
      routes: [FriendsRoute(), RequestsRoute(), SuggestionsRoute()],
      builder: ((context, child, tabController) {
        return Column(
          children: [_tabBar(tabController), Expanded(child: child)],
        );
      }),
    ));
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
              tabs: [
                Tab(text: appLocalizations.friendsTab),
                Tab(text: appLocalizations.requestsTab),
                Tab(text: appLocalizations.suggestionsTab)
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
          color: ColorTheme.secondaryColor),
    );
  }
}
