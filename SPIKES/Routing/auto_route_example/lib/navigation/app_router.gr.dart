// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<HomeWrapperRouteArgs>(
          orElse: () => const HomeWrapperRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: HomeWrapperPage(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ItemListRoute.name: (routeData) {
      final args = routeData.argsAs<ItemListRouteArgs>(
          orElse: () => const ItemListRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ItemListPage(key: args.key),
      );
    },
    ItemRoute.name: (routeData) {
      final args =
          routeData.argsAs<ItemRouteArgs>(orElse: () => const ItemRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ItemPage(key: args.key),
      );
    },
    NavigateToListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const NavigateToListPage(),
      );
    },
    BottomMenuRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BottomMenuPage(),
      );
    },
    BottomMenuSecondRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BottomMenuSecondPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          HomeWrapperRoute.name,
          path: '/',
          children: [
            RouteConfig(
              HomeRoute.name,
              path: 'home-page',
              parent: HomeWrapperRoute.name,
              children: [
                RouteConfig(
                  NavigateToListRoute.name,
                  path: 'navigate-to-list-page',
                  parent: HomeRoute.name,
                ),
                RouteConfig(
                  BottomMenuRoute.name,
                  path: 'bottom-menu-page',
                  parent: HomeRoute.name,
                ),
                RouteConfig(
                  BottomMenuSecondRoute.name,
                  path: 'bottom-menu-second-page',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            RouteConfig(
              ItemListRoute.name,
              path: 'item-list-page',
              parent: HomeWrapperRoute.name,
            ),
            RouteConfig(
              ItemRoute.name,
              path: 'item-page',
              parent: HomeWrapperRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [HomeWrapperPage]
class HomeWrapperRoute extends PageRouteInfo<HomeWrapperRouteArgs> {
  HomeWrapperRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeWrapperRoute.name,
          path: '/',
          args: HomeWrapperRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';
}

class HomeWrapperRouteArgs {
  const HomeWrapperRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeWrapperRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home-page',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ItemListPage]
class ItemListRoute extends PageRouteInfo<ItemListRouteArgs> {
  ItemListRoute({Key? key})
      : super(
          ItemListRoute.name,
          path: 'item-list-page',
          args: ItemListRouteArgs(key: key),
        );

  static const String name = 'ItemListRoute';
}

class ItemListRouteArgs {
  const ItemListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ItemListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ItemPage]
class ItemRoute extends PageRouteInfo<ItemRouteArgs> {
  ItemRoute({Key? key})
      : super(
          ItemRoute.name,
          path: 'item-page',
          args: ItemRouteArgs(key: key),
        );

  static const String name = 'ItemRoute';
}

class ItemRouteArgs {
  const ItemRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ItemRouteArgs{key: $key}';
  }
}

/// generated route for
/// [NavigateToListPage]
class NavigateToListRoute extends PageRouteInfo<void> {
  const NavigateToListRoute()
      : super(
          NavigateToListRoute.name,
          path: 'navigate-to-list-page',
        );

  static const String name = 'NavigateToListRoute';
}

/// generated route for
/// [BottomMenuPage]
class BottomMenuRoute extends PageRouteInfo<void> {
  const BottomMenuRoute()
      : super(
          BottomMenuRoute.name,
          path: 'bottom-menu-page',
        );

  static const String name = 'BottomMenuRoute';
}

/// generated route for
/// [BottomMenuSecondPage]
class BottomMenuSecondRoute extends PageRouteInfo<void> {
  const BottomMenuSecondRoute()
      : super(
          BottomMenuSecondRoute.name,
          path: 'bottom-menu-second-page',
        );

  static const String name = 'BottomMenuSecondRoute';
}
