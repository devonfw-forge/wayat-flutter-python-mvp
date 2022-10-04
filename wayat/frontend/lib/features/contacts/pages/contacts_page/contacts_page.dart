import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Main view of Friends, requests and suggestions page
class ContactsPage extends StatelessWidget {
  /// Business logic controller
  final ContactsPageController controller =
      GetIt.I.get<ContactsPageController>();

  final PlatformService platformService;

  ContactsPage({PlatformService? platformService, Key? key}) : 
    platformService = platformService ?? PlatformService(), 
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          key: const Key("ContactsSearchBar"),
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
      routes: [
        FriendsRoute(), 
        RequestsRoute(), 
        if (!platformService.isWeb) SuggestionsRoute()
      ],
      builder: ((context, child, tabController) {
        controller.updateTabData(tabController.index);
        return Column(
          children: [_tabBar(tabController), Expanded(child: child)],
        );
      }),
    ));
  }

  /// Returns tabBar to change between friends, requests and suggestions page
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
                if (!platformService.isWeb) Tab(text: appLocalizations.suggestionsTab)
              ]),
        ],
      ),
    );
  }

  /// Returns decoration for selected tab
  Decoration _tabIndicator() {
    return const ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.black);
  }

  /// Returns a widget of secondary color place under [tabIndicator]
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
