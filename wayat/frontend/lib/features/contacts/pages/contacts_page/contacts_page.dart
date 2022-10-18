import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/friends_page/friends_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/requests_page/requests_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Main view of Friends, requests and suggestions page
class ContactsPage extends StatefulWidget {
  final String tab;

  final PlatformService platformService;

  ContactsPage(this.tab, {PlatformService? platformService, Key? key})
      : platformService = platformService ?? PlatformService(),
        super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with SingleTickerProviderStateMixin {
  /// Business logic controller
  final ContactsPageController controller =
      GetIt.I.get<ContactsPageController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: (widget.platformService.isWeb) ? 2 : 3, vsync: this);
    controller.updateTabData(_tabController.index);
  }

  @override
  void didUpdateWidget(covariant ContactsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    switch (widget.tab) {
      case 'friends':
        {
          _tabController.index = 0;
          break;
        }
      case 'requests':
        {
          _tabController.index = 1;
          break;
        }
      case 'suggestions':
        {
          _tabController.index = 2;
          break;
        }
    }
    controller.updateTabData(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  Widget contactsPageContent() {
    return Expanded(
        child: Column(
      children: [
        _tabBar(context, _tabController),
        Expanded(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: TabBarView(controller: _tabController, children: [
                FriendsPage(),
                RequestsPage(),
                if (!widget.platformService.isWeb) SuggestionsPage()
              ])),
        ),
      ],
    ));
  }

  /// Returns tabBar to change between friends, requests and suggestions page
  Widget _tabBar(BuildContext context, TabController tabController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          _indicatorBackground(),
          TabBar(
              isScrollable: widget.platformService.isDesktopOrWeb ||
                  widget.platformService.wideUi,
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black45),
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              indicatorPadding: const EdgeInsets.only(top: 45),
              indicator: _tabIndicator(),
              labelColor: Colors.black87,
              controller: tabController,
              onTap: (index) {
                switch (index) {
                  case 0:
                    {
                      context.go('/contacts/friends');
                      break;
                    }
                  case 1:
                    {
                      context.go('/contacts/requests');
                      break;
                    }
                  case 2:
                    {
                      context.go('/contacts/suggestions');
                      break;
                    }
                }
              },
              tabs: [
                Tab(text: appLocalizations.friendsTab),
                Tab(text: appLocalizations.requestsTab),
                if (!widget.platformService.isWeb)
                  Tab(text: appLocalizations.suggestionsTab)
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
