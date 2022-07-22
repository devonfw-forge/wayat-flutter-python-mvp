import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/authenticate/login_page.dart';
import 'package:wayat/notifications/page/notifications_page.dart';
import 'package:wayat/contacts/page/contacts_page.dart';
import 'package:wayat/create_event/page/create_event_page.dart';
import 'package:wayat/domain/contact.dart';
import 'package:wayat/pages/home_page.dart';
import '../contacts/page/contact_detail_page.dart';
import 'package:wayat/pages/home_provisional.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
      page: HomePage, initial: true, children: [
        AutoRoute(page: HomeProvPage),
        AutoRoute(page: ContactsPage, children: [
              AutoRoute(page: ContactDetailPage),
        ]),
        AutoRoute(page: CreateEventPage)
        AutoRoute(page: NotificationsPage),
      ]),
  AutoRoute(page: LoginPage, path: '/login')
])
class AppRouter extends _$AppRouter {}
