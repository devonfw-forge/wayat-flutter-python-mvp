// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;

import '../domain/contact/contact.dart' as _i17;
import '../features/authentication/page/login_page.dart' as _i12;
import '../features/authentication/page/login_wrapper.dart' as _i5;
import '../features/authentication/page/phone_validation_page.dart' as _i13;
import '../features/authentication/page/verification_code_page.dart' as _i14;
import '../features/contacts/pages/contact_detail_page.dart' as _i2;
import '../features/contacts/pages/contacts_page.dart' as _i9;
import '../features/create_event/page/create_event_page.dart' as _i10;
import '../features/home/pages/home_page.dart' as _i4;
import '../features/map/page/home_map_page.dart' as _i8;
import '../features/notifications/page/notifications_page.dart' as _i11;
import '../features/onboarding/pages/onboarding_page.dart' as _i6;
import '../features/onboarding/pages/onboarding_wrapper.dart' as _i3;
import '../features/onboarding/pages/progress_page.dart' as _i7;
import '../features/root/root_wrapper.dart' as _i1;

class AppRouter extends _i15.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    RootWrapper.name: (routeData) {
      final args = routeData.argsAs<RootWrapperArgs>(
          orElse: () => const RootWrapperArgs());
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.RootWrapper(key: args.key));
    },
    ContactDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ContactDetailRouteArgs>();
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.ContactDetailPage(key: args.key, contact: args.contact));
    },
    OnBoardingWrapper.name: (routeData) {
      final args = routeData.argsAs<OnBoardingWrapperArgs>(
          orElse: () => const OnBoardingWrapperArgs());
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.OnBoardingWrapper(key: args.key));
    },
    HomeRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.HomePage());
    },
    LoginWrapper.name: (routeData) {
      final args = routeData.argsAs<LoginWrapperArgs>(
          orElse: () => const LoginWrapperArgs());
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.LoginWrapper(key: args.key));
    },
    OnBoardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingRouteArgs>(
          orElse: () => const OnBoardingRouteArgs());
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.OnBoardingPage(key: args.key));
    },
    ProgressOnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressOnboardingRouteArgs>(
          orElse: () => const ProgressOnboardingRouteArgs());
      return _i15.CustomPage<dynamic>(
          routeData: routeData,
          child: _i7.ProgressOnboardingPage(key: args.key),
          transitionsBuilder: _i15.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HomeMapRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.HomeMapPage());
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.ContactsPage(key: args.key));
    },
    CreateEventRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.CreateEventPage());
    },
    NotificationsRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.NotificationsPage());
    },
    LoginRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.LoginPage());
    },
    PhoneValidationRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.PhoneValidationPage());
    },
    CodeValidationRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.CodeValidationPage());
    }
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(RootWrapper.name, path: '/', children: [
          _i15.RouteConfig(OnBoardingWrapper.name,
              path: 'on-boarding-wrapper',
              parent: RootWrapper.name,
              children: [
                _i15.RouteConfig(OnBoardingRoute.name,
                    path: 'on-boarding-page', parent: OnBoardingWrapper.name),
                _i15.RouteConfig(ProgressOnboardingRoute.name,
                    path: 'progress-onboarding-page',
                    parent: OnBoardingWrapper.name)
              ]),
          _i15.RouteConfig(HomeRoute.name,
              path: 'home-page',
              parent: RootWrapper.name,
              children: [
                _i15.RouteConfig(HomeMapRoute.name,
                    path: 'home-map-page', parent: HomeRoute.name),
                _i15.RouteConfig(ContactsRoute.name,
                    path: 'contacts-page', parent: HomeRoute.name),
                _i15.RouteConfig(CreateEventRoute.name,
                    path: 'create-event-page', parent: HomeRoute.name),
                _i15.RouteConfig(NotificationsRoute.name,
                    path: 'notifications-page', parent: HomeRoute.name)
              ]),
          _i15.RouteConfig(LoginWrapper.name,
              path: 'login-wrapper',
              parent: RootWrapper.name,
              children: [
                _i15.RouteConfig(LoginRoute.name,
                    path: 'login-page', parent: LoginWrapper.name),
                _i15.RouteConfig(PhoneValidationRoute.name,
                    path: 'phone-validation-page', parent: LoginWrapper.name),
                _i15.RouteConfig(CodeValidationRoute.name,
                    path: 'code-validation-page', parent: LoginWrapper.name)
              ])
        ]),
        _i15.RouteConfig(ContactDetailRoute.name, path: '/contact-detail-page')
      ];
}

/// generated route for
/// [_i1.RootWrapper]
class RootWrapper extends _i15.PageRouteInfo<RootWrapperArgs> {
  RootWrapper({_i16.Key? key, List<_i15.PageRouteInfo>? children})
      : super(RootWrapper.name,
            path: '/',
            args: RootWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'RootWrapper';
}

class RootWrapperArgs {
  const RootWrapperArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'RootWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.ContactDetailPage]
class ContactDetailRoute extends _i15.PageRouteInfo<ContactDetailRouteArgs> {
  ContactDetailRoute({_i16.Key? key, required _i17.Contact contact})
      : super(ContactDetailRoute.name,
            path: '/contact-detail-page',
            args: ContactDetailRouteArgs(key: key, contact: contact));

  static const String name = 'ContactDetailRoute';
}

class ContactDetailRouteArgs {
  const ContactDetailRouteArgs({this.key, required this.contact});

  final _i16.Key? key;

  final _i17.Contact contact;

  @override
  String toString() {
    return 'ContactDetailRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [_i3.OnBoardingWrapper]
class OnBoardingWrapper extends _i15.PageRouteInfo<OnBoardingWrapperArgs> {
  OnBoardingWrapper({_i16.Key? key, List<_i15.PageRouteInfo>? children})
      : super(OnBoardingWrapper.name,
            path: 'on-boarding-wrapper',
            args: OnBoardingWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'OnBoardingWrapper';
}

class OnBoardingWrapperArgs {
  const OnBoardingWrapperArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'OnBoardingWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.LoginWrapper]
class LoginWrapper extends _i15.PageRouteInfo<LoginWrapperArgs> {
  LoginWrapper({_i16.Key? key, List<_i15.PageRouteInfo>? children})
      : super(LoginWrapper.name,
            path: 'login-wrapper',
            args: LoginWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'LoginWrapper';
}

class LoginWrapperArgs {
  const LoginWrapperArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'LoginWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.OnBoardingPage]
class OnBoardingRoute extends _i15.PageRouteInfo<OnBoardingRouteArgs> {
  OnBoardingRoute({_i16.Key? key})
      : super(OnBoardingRoute.name,
            path: 'on-boarding-page', args: OnBoardingRouteArgs(key: key));

  static const String name = 'OnBoardingRoute';
}

class OnBoardingRouteArgs {
  const OnBoardingRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'OnBoardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.ProgressOnboardingPage]
class ProgressOnboardingRoute
    extends _i15.PageRouteInfo<ProgressOnboardingRouteArgs> {
  ProgressOnboardingRoute({_i16.Key? key})
      : super(ProgressOnboardingRoute.name,
            path: 'progress-onboarding-page',
            args: ProgressOnboardingRouteArgs(key: key));

  static const String name = 'ProgressOnboardingRoute';
}

class ProgressOnboardingRouteArgs {
  const ProgressOnboardingRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'ProgressOnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.HomeMapPage]
class HomeMapRoute extends _i15.PageRouteInfo<void> {
  const HomeMapRoute() : super(HomeMapRoute.name, path: 'home-map-page');

  static const String name = 'HomeMapRoute';
}


/// generated route for
/// [_i9.ContactsPage]
class ContactsRoute extends _i15.PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({_i16.Key? key})
      : super(ContactsRoute.name,
            path: 'contacts-page', args: ContactsRouteArgs(key: key));

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.CreateEventPage]
class CreateEventRoute extends _i15.PageRouteInfo<void> {
  const CreateEventRoute()
      : super(CreateEventRoute.name, path: 'create-event-page');

  static const String name = 'CreateEventRoute';
}

/// generated route for
/// [_i11.NotificationsPage]
class NotificationsRoute extends _i15.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i12.LoginPage]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i13.PhoneValidationPage]
class PhoneValidationRoute extends _i15.PageRouteInfo<void> {
  const PhoneValidationRoute()
      : super(PhoneValidationRoute.name, path: 'phone-validation-page');

  static const String name = 'PhoneValidationRoute';
}

/// generated route for
/// [_i14.CodeValidationPage]
class CodeValidationRoute extends _i15.PageRouteInfo<void> {
  const CodeValidationRoute()
      : super(CodeValidationRoute.name, path: 'code-validation-page');

  static const String name = 'CodeValidationRoute';
}
