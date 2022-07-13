import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/mock/product.dart';
import 'package:auto_route_example/pages/bottom_menu.dart';
import 'package:auto_route_example/pages/bottom_menu_second.dart';
import 'package:auto_route_example/pages/home_page.dart';
import 'package:auto_route_example/pages/item_page.dart';
import 'package:auto_route_example/pages/list_items.dart';
import 'package:auto_route_example/pages/navigate_to_list_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: HomePage, initial: true, children: [
    AutoRoute(page: NavigateToListPage),
    AutoRoute(page: BottomMenuPage),
    AutoRoute(page: BottomMenuSecondPage),
  ]),
  AutoRoute(page: ListItemsPage),
  AutoRoute(page: ListItemsPage),
  AutoRoute(page: ItemPage),
])
class AppRouter extends _$AppRouter {}
