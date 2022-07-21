import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/authenticate/login_page.dart';
import 'package:wayat/contacts/page/contacts_page.dart';
import 'package:wayat/create_event/page/create_event_page.dart';
import 'package:wayat/pages/home_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true, children: [
    AutoRoute(page: ContactsPage),
    AutoRoute(page: CreateEventPage)
  ]),
  AutoRoute(page: LoginPage, path: '/login')
])
class AppRouter extends _$AppRouter {}
