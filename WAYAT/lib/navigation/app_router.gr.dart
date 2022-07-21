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
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: HomePage(key: args.key));
    },
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const LoginPage());
    },
    HomeProvRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: HomeProvPage());
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: ContactsPage(key: args.key));
    },
    NotificationsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const NotificationsPage());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: ContactsPage(key: args.key));
    },
    CreateEventRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const CreateEventPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(HomeRoute.name, path: '/', children: [
          RouteConfig(HomeProvRoute.name,
              path: 'home-prov-page', parent: HomeRoute.name),
          RouteConfig(ContactsRoute.name,
              path: 'contacts-page', parent: HomeRoute.name),
          RouteConfig(NotificationsRoute.name,
              path: 'notifications-page', parent: HomeRoute.name)
          RouteConfig(CreateEventRoute.name,
              path: 'create-event-page', parent: HomeRoute.name)
        ]),
        RouteConfig(LoginRoute.name, path: '/login')
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({Key? key, List<PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/',
            args: HomeRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [HomeProvPage]
class HomeProvRoute extends PageRouteInfo<void> {
  const HomeProvRoute() : super(HomeProvRoute.name, path: 'home-prov-page');

  static const String name = 'HomeProvRoute';
}

/// generated route for
/// [ContactsPage]
class ContactsRoute extends PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({Key? key})
      : super(ContactsRoute.name,
            path: 'contacts-page', args: ContactsRouteArgs(key: key));

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [NotificationsPage]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
/// [CreateEventPage]
class CreateEventRoute extends PageRouteInfo<void> {
  const CreateEventRoute()
      : super(CreateEventRoute.name, path: 'create-event-page');

  static const String name = 'CreateEventRoute';
}
