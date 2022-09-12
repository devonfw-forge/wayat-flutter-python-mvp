import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class ContactsWrapper extends StatelessWidget {
  final ContactsPageController controller =
      GetIt.I.get<ContactsPageController>();

  ContactsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      ContactsCurrentPages currentPage = controller.currentPage;
      return AutoRouter.declarative(
          routes: (_) => [
                ContactsRoute(),
                if (currentPage != ContactsCurrentPages.contacts)
                  getCurrentRoute(currentPage),
                if (currentPage == ContactsCurrentPages.manageGroup)
                  ManageGroupRoute()
              ]);
    });
  }

  PageRouteInfo<dynamic> getCurrentRoute(ContactsCurrentPages currentPage) {
    switch (currentPage) {
      case ContactsCurrentPages.contacts:
        return ContactsRoute();
      case ContactsCurrentPages.sentRequests:
        return SentRequestsRoute();
      case ContactsCurrentPages.manageGroup:
      case ContactsCurrentPages.groups:
        return GroupsRoute();
    }
  }
}
