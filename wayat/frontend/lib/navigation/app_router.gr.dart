// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../domain/contact/contact.dart' as _i12;
import '../features/authentication/page/login_page.dart' as _i2;
import '../features/contacts/pages/contact_detail_page.dart' as _i3;
import '../features/contacts/pages/contacts_page.dart' as _i7;
import '../features/create_event/page/create_event_page.dart' as _i8;
import '../features/home/pages/home_page.dart' as _i1;
import '../features/home/pages/home_provisional.dart' as _i6;
import '../features/notifications/page/notifications_page.dart' as _i9;
import '../features/onboarding/pages/onboarding_page.dart' as _i4;
import '../features/onboarding/pages/progress_page.dart' as _i5;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.HomePage(key: args.key));
    },
    LoginRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    ContactDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ContactDetailRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ContactDetailPage(key: args.key, contact: args.contact));
    },
    OnBoardingRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.OnBoardingPage());
    },
    ProgressOnboardingRoute.name: (routeData) {
      return _i10.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.ProgressOnboardingPage(),
          transitionsBuilder: _i10.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HomeProvRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.HomeProvPage());
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.ContactsPage(key: args.key));
    },
    CreateEventRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CreateEventPage());
    },
    NotificationsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.NotificationsPage());
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(HomeRoute.name, path: '/', children: [
          _i10.RouteConfig(HomeProvRoute.name,
              path: 'home-prov-page', parent: HomeRoute.name),
          _i10.RouteConfig(ContactsRoute.name,
              path: 'contacts-page', parent: HomeRoute.name),
          _i10.RouteConfig(CreateEventRoute.name,
              path: 'create-event-page', parent: HomeRoute.name),
          _i10.RouteConfig(NotificationsRoute.name,
              path: 'notifications-page', parent: HomeRoute.name)
        ]),
        _i10.RouteConfig(LoginRoute.name, path: '/login'),
        _i10.RouteConfig(ContactDetailRoute.name, path: '/contact-detail-page'),
        _i10.RouteConfig(OnBoardingRoute.name, path: '/on-boarding-page'),
        _i10.RouteConfig(ProgressOnboardingRoute.name,
            path: '/progress-onboarding-page')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i10.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i11.Key? key, List<_i10.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/',
            args: HomeRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.ContactDetailPage]
class ContactDetailRoute extends _i10.PageRouteInfo<ContactDetailRouteArgs> {
  ContactDetailRoute({_i11.Key? key, required _i12.Contact contact})
      : super(ContactDetailRoute.name,
            path: '/contact-detail-page',
            args: ContactDetailRouteArgs(key: key, contact: contact));

  static const String name = 'ContactDetailRoute';
}

class ContactDetailRouteArgs {
  const ContactDetailRouteArgs({this.key, required this.contact});

  final _i11.Key? key;

  final _i12.Contact contact;

  @override
  String toString() {
    return 'ContactDetailRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [_i4.OnBoardingPage]
class OnBoardingRoute extends _i10.PageRouteInfo<void> {
  const OnBoardingRoute()
      : super(OnBoardingRoute.name, path: '/on-boarding-page');

  static const String name = 'OnBoardingRoute';
}

/// generated route for
/// [_i5.ProgressOnboardingPage]
class ProgressOnboardingRoute extends _i10.PageRouteInfo<void> {
  const ProgressOnboardingRoute()
      : super(ProgressOnboardingRoute.name, path: '/progress-onboarding-page');

  static const String name = 'ProgressOnboardingRoute';
}

/// generated route for
/// [_i6.HomeProvPage]
class HomeProvRoute extends _i10.PageRouteInfo<void> {
  const HomeProvRoute() : super(HomeProvRoute.name, path: 'home-prov-page');

  static const String name = 'HomeProvRoute';
}

/// generated route for
/// [_i7.ContactsPage]
class ContactsRoute extends _i10.PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({_i11.Key? key})
      : super(ContactsRoute.name,
            path: 'contacts-page', args: ContactsRouteArgs(key: key));

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.CreateEventPage]
class CreateEventRoute extends _i10.PageRouteInfo<void> {
  const CreateEventRoute()
      : super(CreateEventRoute.name, path: 'create-event-page');

  static const String name = 'CreateEventRoute';
}

/// generated route for
/// [_i9.NotificationsPage]
class NotificationsRoute extends _i10.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
}
