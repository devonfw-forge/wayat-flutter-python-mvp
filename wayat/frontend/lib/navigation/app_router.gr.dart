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
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/material.dart' as _i21;

import '../domain/contact/contact.dart' as _i22;
import '../features/authentication/page/loading_page.dart' as _i19;
import '../features/authentication/page/login_page.dart' as _i17;
import '../features/authentication/page/login_wrapper.dart' as _i5;
import '../features/authentication/page/phone_validation_page.dart' as _i18;
import '../features/contacts/pages/contact_detail_page.dart' as _i2;
import '../features/contacts/pages/contacts_page.dart' as _i12;
import '../features/contacts/pages/contacts_wrapper.dart' as _i10;
import '../features/contacts/pages/friends_page.dart' as _i14;
import '../features/contacts/pages/requests_page.dart' as _i15;
import '../features/contacts/pages/sent_requests_page.dart' as _i13;
import '../features/contacts/pages/suggestions_page.dart' as _i16;
import '../features/create_event/page/create_event_page.dart' as _i9;
import '../features/home/pages/home_page.dart' as _i4;
import '../features/map/page/home_map_page.dart' as _i8;
import '../features/notifications/page/notifications_page.dart' as _i11;
import '../features/onboarding/pages/onboarding_page.dart' as _i6;
import '../features/onboarding/pages/onboarding_wrapper.dart' as _i3;
import '../features/onboarding/pages/progress_page.dart' as _i7;
import '../features/root/root_wrapper.dart' as _i1;

class AppRouter extends _i20.RootStackRouter {
  AppRouter([_i21.GlobalKey<_i21.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    RootWrapper.name: (routeData) {
      final args = routeData.argsAs<RootWrapperArgs>(
          orElse: () => const RootWrapperArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.RootWrapper(key: args.key));
    },
    ContactDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ContactDetailRouteArgs>();
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.ContactDetailPage(key: args.key, contact: args.contact));
    },
    OnBoardingWrapper.name: (routeData) {
      final args = routeData.argsAs<OnBoardingWrapperArgs>(
          orElse: () => const OnBoardingWrapperArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.OnBoardingWrapper(key: args.key));
    },
    HomeRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.HomePage());
    },
    LoginWrapper.name: (routeData) {
      final args = routeData.argsAs<LoginWrapperArgs>(
          orElse: () => const LoginWrapperArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.LoginWrapper(key: args.key));
    },
    OnBoardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingRouteArgs>(
          orElse: () => const OnBoardingRouteArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.OnBoardingPage(key: args.key));
    },
    ProgressOnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressOnboardingRouteArgs>(
          orElse: () => const ProgressOnboardingRouteArgs());
      return _i20.CustomPage<dynamic>(
          routeData: routeData,
          child: _i7.ProgressOnboardingPage(key: args.key),
          transitionsBuilder: _i20.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HomeMapRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMapRouteArgs>(
          orElse: () => const HomeMapRouteArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.HomeMapPage(key: args.key));
    },
    CreateEventRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CreateEventPage());
    },
    ContactsWrapper.name: (routeData) {
      final args = routeData.argsAs<ContactsWrapperArgs>(
          orElse: () => const ContactsWrapperArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.ContactsWrapper(key: args.key));
    },
    NotificationsRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.NotificationsPage());
    },
    ContactsRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.ContactsPage());
    },
    SentRequestsRoute.name: (routeData) {
      final args = routeData.argsAs<SentRequestsRouteArgs>(
          orElse: () => const SentRequestsRouteArgs());
      return _i20.CustomPage<dynamic>(
          routeData: routeData,
          child: _i13.SentRequestsPage(key: args.key),
          transitionsBuilder: _i20.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    FriendsRoute.name: (routeData) {
      final args = routeData.argsAs<FriendsRouteArgs>(
          orElse: () => const FriendsRouteArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.FriendsPage(key: args.key));
    },
    RequestsRoute.name: (routeData) {
      final args = routeData.argsAs<RequestsRouteArgs>(
          orElse: () => const RequestsRouteArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i15.RequestsPage(key: args.key));
    },
    SuggestionsRoute.name: (routeData) {
      final args = routeData.argsAs<SuggestionsRouteArgs>(
          orElse: () => const SuggestionsRouteArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i16.SuggestionsPage(key: args.key));
    },
    LoginRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.LoginPage());
    },
    PhoneValidationRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.PhoneValidationPage());
    },
    LoadingRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.LoadingPage());
    }
  };

  @override
  List<_i20.RouteConfig> get routes => [
        _i20.RouteConfig(RootWrapper.name, path: '/', children: [
          _i20.RouteConfig(OnBoardingWrapper.name,
              path: 'on-boarding-wrapper',
              parent: RootWrapper.name,
              children: [
                _i20.RouteConfig(OnBoardingRoute.name,
                    path: 'on-boarding-page', parent: OnBoardingWrapper.name),
                _i20.RouteConfig(ProgressOnboardingRoute.name,
                    path: 'progress-onboarding-page',
                    parent: OnBoardingWrapper.name)
              ]),
          _i20.RouteConfig(HomeRoute.name,
              path: 'home-page',
              parent: RootWrapper.name,
              children: [
                _i20.RouteConfig(HomeMapRoute.name,
                    path: 'home-map-page', parent: HomeRoute.name),
                _i20.RouteConfig(CreateEventRoute.name,
                    path: 'create-event-page', parent: HomeRoute.name),
                _i20.RouteConfig(ContactsWrapper.name,
                    path: 'contacts-wrapper',
                    parent: HomeRoute.name,
                    children: [
                      _i20.RouteConfig(ContactsRoute.name,
                          path: 'contacts-page',
                          parent: ContactsWrapper.name,
                          children: [
                            _i20.RouteConfig(FriendsRoute.name,
                                path: 'friends-page',
                                parent: ContactsRoute.name),
                            _i20.RouteConfig(RequestsRoute.name,
                                path: 'requests-page',
                                parent: ContactsRoute.name),
                            _i20.RouteConfig(SuggestionsRoute.name,
                                path: 'suggestions-page',
                                parent: ContactsRoute.name)
                          ]),
                      _i20.RouteConfig(SentRequestsRoute.name,
                          path: 'sent-requests-page',
                          parent: ContactsWrapper.name)
                    ]),
                _i20.RouteConfig(NotificationsRoute.name,
                    path: 'notifications-page', parent: HomeRoute.name)
              ]),
          _i20.RouteConfig(LoginWrapper.name,
              path: 'login-wrapper',
              parent: RootWrapper.name,
              children: [
                _i20.RouteConfig(LoginRoute.name,
                    path: 'login-page', parent: LoginWrapper.name),
                _i20.RouteConfig(PhoneValidationRoute.name,
                    path: 'phone-validation-page', parent: LoginWrapper.name),
                _i20.RouteConfig(LoadingRoute.name,
                    path: 'loading-page', parent: LoginWrapper.name)
              ])
        ]),
        _i20.RouteConfig(ContactDetailRoute.name, path: '/contact-detail-page')
      ];
}

/// generated route for
/// [_i1.RootWrapper]
class RootWrapper extends _i20.PageRouteInfo<RootWrapperArgs> {
  RootWrapper({_i21.Key? key, List<_i20.PageRouteInfo>? children})
      : super(RootWrapper.name,
            path: '/',
            args: RootWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'RootWrapper';
}

class RootWrapperArgs {
  const RootWrapperArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'RootWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.ContactDetailPage]
class ContactDetailRoute extends _i20.PageRouteInfo<ContactDetailRouteArgs> {
  ContactDetailRoute({_i21.Key? key, required _i22.Contact contact})
      : super(ContactDetailRoute.name,
            path: '/contact-detail-page',
            args: ContactDetailRouteArgs(key: key, contact: contact));

  static const String name = 'ContactDetailRoute';
}

class ContactDetailRouteArgs {
  const ContactDetailRouteArgs({this.key, required this.contact});

  final _i21.Key? key;

  final _i22.Contact contact;

  @override
  String toString() {
    return 'ContactDetailRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [_i3.OnBoardingWrapper]
class OnBoardingWrapper extends _i20.PageRouteInfo<OnBoardingWrapperArgs> {
  OnBoardingWrapper({_i21.Key? key, List<_i20.PageRouteInfo>? children})
      : super(OnBoardingWrapper.name,
            path: 'on-boarding-wrapper',
            args: OnBoardingWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'OnBoardingWrapper';
}

class OnBoardingWrapperArgs {
  const OnBoardingWrapperArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'OnBoardingWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i20.PageRouteInfo<void> {
  const HomeRoute({List<_i20.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.LoginWrapper]
class LoginWrapper extends _i20.PageRouteInfo<LoginWrapperArgs> {
  LoginWrapper({_i21.Key? key, List<_i20.PageRouteInfo>? children})
      : super(LoginWrapper.name,
            path: 'login-wrapper',
            args: LoginWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'LoginWrapper';
}

class LoginWrapperArgs {
  const LoginWrapperArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'LoginWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.OnBoardingPage]
class OnBoardingRoute extends _i20.PageRouteInfo<OnBoardingRouteArgs> {
  OnBoardingRoute({_i21.Key? key})
      : super(OnBoardingRoute.name,
            path: 'on-boarding-page', args: OnBoardingRouteArgs(key: key));

  static const String name = 'OnBoardingRoute';
}

class OnBoardingRouteArgs {
  const OnBoardingRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'OnBoardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.ProgressOnboardingPage]
class ProgressOnboardingRoute
    extends _i20.PageRouteInfo<ProgressOnboardingRouteArgs> {
  ProgressOnboardingRoute({_i21.Key? key})
      : super(ProgressOnboardingRoute.name,
            path: 'progress-onboarding-page',
            args: ProgressOnboardingRouteArgs(key: key));

  static const String name = 'ProgressOnboardingRoute';
}

class ProgressOnboardingRouteArgs {
  const ProgressOnboardingRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'ProgressOnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.HomeMapPage]
class HomeMapRoute extends _i20.PageRouteInfo<HomeMapRouteArgs> {
  HomeMapRoute({_i21.Key? key})
      : super(HomeMapRoute.name,
            path: 'home-map-page', args: HomeMapRouteArgs(key: key));

  static const String name = 'HomeMapRoute';
}

class HomeMapRouteArgs {
  const HomeMapRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'HomeMapRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.CreateEventPage]
class CreateEventRoute extends _i20.PageRouteInfo<void> {
  const CreateEventRoute()
      : super(CreateEventRoute.name, path: 'create-event-page');

  static const String name = 'CreateEventRoute';
}

/// generated route for
/// [_i10.ContactsWrapper]
class ContactsWrapper extends _i20.PageRouteInfo<ContactsWrapperArgs> {
  ContactsWrapper({_i21.Key? key, List<_i20.PageRouteInfo>? children})
      : super(ContactsWrapper.name,
            path: 'contacts-wrapper',
            args: ContactsWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'ContactsWrapper';
}

class ContactsWrapperArgs {
  const ContactsWrapperArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'ContactsWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.NotificationsPage]
class NotificationsRoute extends _i20.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i12.ContactsPage]
class ContactsRoute extends _i20.PageRouteInfo<void> {
  const ContactsRoute({List<_i20.PageRouteInfo>? children})
      : super(ContactsRoute.name,
            path: 'contacts-page', initialChildren: children);

  static const String name = 'ContactsRoute';
}

/// generated route for
/// [_i13.SentRequestsPage]
class SentRequestsRoute extends _i20.PageRouteInfo<SentRequestsRouteArgs> {
  SentRequestsRoute({_i21.Key? key})
      : super(SentRequestsRoute.name,
            path: 'sent-requests-page', args: SentRequestsRouteArgs(key: key));

  static const String name = 'SentRequestsRoute';
}

class SentRequestsRouteArgs {
  const SentRequestsRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'SentRequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.FriendsPage]
class FriendsRoute extends _i20.PageRouteInfo<FriendsRouteArgs> {
  FriendsRoute({_i21.Key? key})
      : super(FriendsRoute.name,
            path: 'friends-page', args: FriendsRouteArgs(key: key));

  static const String name = 'FriendsRoute';
}

class FriendsRouteArgs {
  const FriendsRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'FriendsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.RequestsPage]
class RequestsRoute extends _i20.PageRouteInfo<RequestsRouteArgs> {
  RequestsRoute({_i21.Key? key})
      : super(RequestsRoute.name,
            path: 'requests-page', args: RequestsRouteArgs(key: key));

  static const String name = 'RequestsRoute';
}

class RequestsRouteArgs {
  const RequestsRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'RequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.SuggestionsPage]
class SuggestionsRoute extends _i20.PageRouteInfo<SuggestionsRouteArgs> {
  SuggestionsRoute({_i21.Key? key})
      : super(SuggestionsRoute.name,
            path: 'suggestions-page', args: SuggestionsRouteArgs(key: key));

  static const String name = 'SuggestionsRoute';
}

class SuggestionsRouteArgs {
  const SuggestionsRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'SuggestionsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.LoginPage]
class LoginRoute extends _i20.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i18.PhoneValidationPage]
class PhoneValidationRoute extends _i20.PageRouteInfo<void> {
  const PhoneValidationRoute()
      : super(PhoneValidationRoute.name, path: 'phone-validation-page');

  static const String name = 'PhoneValidationRoute';
}

/// generated route for
/// [_i19.LoadingPage]
class LoadingRoute extends _i20.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: 'loading-page');

  static const String name = 'LoadingRoute';
}
