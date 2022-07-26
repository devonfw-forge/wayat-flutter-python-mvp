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
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    ItemListRoute.name: (routeData) {
      final args = routeData.argsAs<ItemListRouteArgs>(
          orElse: () => const ItemListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: ItemListPage(key: args.key));
    },
    ItemRoute.name: (routeData) {
      final args = routeData.argsAs<ItemRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ItemPage(key: args.key, product: args.product));
    },
    NavigateToListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const NavigateToListPage());
    },
    BottomMenuRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const BottomMenuPage());
    },
    BottomMenuSecondRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const BottomMenuSecondPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(HomeRoute.name, path: '/', children: [
          RouteConfig(NavigateToListRoute.name,
              path: 'navigate-to-list-page', parent: HomeRoute.name),
          RouteConfig(BottomMenuRoute.name,
              path: 'bottom-menu-page', parent: HomeRoute.name),
          RouteConfig(BottomMenuSecondRoute.name,
              path: 'bottom-menu-second-page', parent: HomeRoute.name)
        ]),
        RouteConfig(ItemListRoute.name, path: '/item-list-page'),
        RouteConfig(ItemRoute.name, path: '/item-page')
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ItemListPage]
class ItemListRoute extends PageRouteInfo<ItemListRouteArgs> {
  ItemListRoute({Key? key})
      : super(ItemListRoute.name,
            path: '/item-list-page', args: ItemListRouteArgs(key: key));

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
  ItemRoute({Key? key, required Product product})
      : super(ItemRoute.name,
            path: '/item-page',
            args: ItemRouteArgs(key: key, product: product));

  static const String name = 'ItemRoute';
}

class ItemRouteArgs {
  const ItemRouteArgs({this.key, required this.product});

  final Key? key;

  final Product product;

  @override
  String toString() {
    return 'ItemRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [NavigateToListPage]
class NavigateToListRoute extends PageRouteInfo<void> {
  const NavigateToListRoute()
      : super(NavigateToListRoute.name, path: 'navigate-to-list-page');

  static const String name = 'NavigateToListRoute';
}

/// generated route for
/// [BottomMenuPage]
class BottomMenuRoute extends PageRouteInfo<void> {
  const BottomMenuRoute()
      : super(BottomMenuRoute.name, path: 'bottom-menu-page');

  static const String name = 'BottomMenuRoute';
}

/// generated route for
/// [BottomMenuSecondPage]
class BottomMenuSecondRoute extends PageRouteInfo<void> {
  const BottomMenuSecondRoute()
      : super(BottomMenuSecondRoute.name, path: 'bottom-menu-second-page');

  static const String name = 'BottomMenuSecondRoute';
}
