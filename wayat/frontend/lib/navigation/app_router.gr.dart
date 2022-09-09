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
import 'package:auto_route/auto_route.dart' as _i24;
import 'package:flutter/material.dart' as _i25;

import '../domain/contact/contact.dart' as _i26;
import '../features/authentication/page/loading_page.dart' as _i23;
import '../features/authentication/page/login_page.dart' as _i21;
import '../features/authentication/page/login_wrapper.dart' as _i4;
import '../features/authentication/page/phone_validation_page.dart' as _i22;
import '../features/contact_profile/controller/contact_profile_controller.dart'
    as _i27;
import '../features/contact_profile/page/contact_profile_page.dart' as _i8;
import '../features/contacts/pages/contacts_page/contacts_page.dart' as _i13;
import '../features/contacts/pages/contacts_page/friends_page/friends_page.dart'
    as _i15;
import '../features/contacts/pages/contacts_page/requests_page/requests_page.dart'
    as _i16;
import '../features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart'
    as _i17;
import '../features/contacts/pages/contacts_wrapper.dart' as _i10;
import '../features/contacts/pages/sent_requests_page/sent_requests_page.dart'
    as _i14;
import '../features/home/pages/home_page.dart' as _i7;
import '../features/home/pages/home_wrapper.dart' as _i3;
import '../features/map/controller/map_controller.dart' as _i28;
import '../features/map/page/home_map_page.dart' as _i9;
import '../features/notifications/page/notifications_page.dart' as _i11;
import '../features/onboarding/pages/onboarding_page.dart' as _i5;
import '../features/onboarding/pages/onboarding_wrapper.dart' as _i2;
import '../features/onboarding/pages/progress_page.dart' as _i6;
import '../features/profile/pages/edit_profile_page.dart' as _i19;
import '../features/profile/pages/preferences_page.dart' as _i20;
import '../features/profile/pages/profile_page.dart' as _i18;
import '../features/profile/pages/profile_wraper.dart' as _i12;
import '../features/root/root_wrapper.dart' as _i1;

class AppRouter extends _i24.RootStackRouter {
  AppRouter([_i25.GlobalKey<_i25.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i24.PageFactory> pagesMap = {
    RootWrapper.name: (routeData) {
      final args = routeData.argsAs<RootWrapperArgs>(
          orElse: () => const RootWrapperArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.RootWrapper(key: args.key));
    },
    OnBoardingWrapper.name: (routeData) {
      final args = routeData.argsAs<OnBoardingWrapperArgs>(
          orElse: () => const OnBoardingWrapperArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.OnBoardingWrapper(key: args.key));
    },
    HomeWrapper.name: (routeData) {
      final args = routeData.argsAs<HomeWrapperArgs>(
          orElse: () => const HomeWrapperArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.HomeWrapper(key: args.key));
    },
    LoginWrapper.name: (routeData) {
      final args = routeData.argsAs<LoginWrapperArgs>(
          orElse: () => const LoginWrapperArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.LoginWrapper(key: args.key));
    },
    OnBoardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingRouteArgs>(
          orElse: () => const OnBoardingRouteArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.OnBoardingPage(key: args.key));
    },
    ProgressOnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressOnboardingRouteArgs>(
          orElse: () => const ProgressOnboardingRouteArgs());
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i6.ProgressOnboardingPage(key: args.key),
          transitionsBuilder: _i24.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HomeRoute.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.HomePage());
    },
    ContactProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ContactProfileRouteArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.ContactProfilePage(
              contact: args.contact,
              navigationSource: args.navigationSource,
              controller: args.controller,
              key: args.key));
    },
    HomeMapRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMapRouteArgs>(
          orElse: () => const HomeMapRouteArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.HomeMapPage(controller: args.controller, key: args.key));
    },
    ContactsWrapper.name: (routeData) {
      final args = routeData.argsAs<ContactsWrapperArgs>(
          orElse: () => const ContactsWrapperArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.ContactsWrapper(key: args.key));
    },
    NotificationsRoute.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.NotificationsPage());
    },
    ProfileWrapper.name: (routeData) {
      final args = routeData.argsAs<ProfileWrapperArgs>(
          orElse: () => const ProfileWrapperArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.ProfileWrapper(key: args.key));
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.ContactsPage(key: args.key));
    },
    SentRequestsRoute.name: (routeData) {
      final args = routeData.argsAs<SentRequestsRouteArgs>(
          orElse: () => const SentRequestsRouteArgs());
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i14.SentRequestsPage(key: args.key),
          transitionsBuilder: _i24.TransitionsBuilders.slideLeftWithFade,
          opaque: true,
          barrierDismissible: false);
    },
    FriendsRoute.name: (routeData) {
      final args = routeData.argsAs<FriendsRouteArgs>(
          orElse: () => const FriendsRouteArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i15.FriendsPage(key: args.key));
    },
    RequestsRoute.name: (routeData) {
      final args = routeData.argsAs<RequestsRouteArgs>(
          orElse: () => const RequestsRouteArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i16.RequestsPage(key: args.key));
    },
    SuggestionsRoute.name: (routeData) {
      final args = routeData.argsAs<SuggestionsRouteArgs>(
          orElse: () => const SuggestionsRouteArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i17.SuggestionsPage(key: args.key));
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i18.ProfilePage(key: args.key));
    },
    EditProfileRoute.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.EditProfilePage());
    },
    PreferencesRoute.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i20.PreferencesPage());
    },
    LoginRoute.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.LoginPage());
    },
    PhoneValidationRoute.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i22.PhoneValidationPage());
    },
    LoadingRoute.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.LoadingPage());
    }
  };

  @override
  List<_i24.RouteConfig> get routes => [
        _i24.RouteConfig(RootWrapper.name, path: '/', children: [
          _i24.RouteConfig(OnBoardingWrapper.name,
              path: 'on-boarding-wrapper',
              parent: RootWrapper.name,
              children: [
                _i24.RouteConfig(OnBoardingRoute.name,
                    path: 'on-boarding-page', parent: OnBoardingWrapper.name),
                _i24.RouteConfig(ProgressOnboardingRoute.name,
                    path: 'progress-onboarding-page',
                    parent: OnBoardingWrapper.name)
              ]),
          _i24.RouteConfig(HomeWrapper.name,
              path: 'home-wrapper',
              parent: RootWrapper.name,
              children: [
                _i24.RouteConfig(HomeRoute.name,
                    path: 'home-page',
                    parent: HomeWrapper.name,
                    children: [
                      _i24.RouteConfig(HomeMapRoute.name,
                          path: 'home-map-page', parent: HomeRoute.name),
                      _i24.RouteConfig(ContactsWrapper.name,
                          path: 'contacts-wrapper',
                          parent: HomeRoute.name,
                          children: [
                            _i24.RouteConfig(ContactsRoute.name,
                                path: 'contacts-page',
                                parent: ContactsWrapper.name,
                                children: [
                                  _i24.RouteConfig(FriendsRoute.name,
                                      path: 'friends-page',
                                      parent: ContactsRoute.name),
                                  _i24.RouteConfig(RequestsRoute.name,
                                      path: 'requests-page',
                                      parent: ContactsRoute.name),
                                  _i24.RouteConfig(SuggestionsRoute.name,
                                      path: 'suggestions-page',
                                      parent: ContactsRoute.name)
                                ]),
                            _i24.RouteConfig(SentRequestsRoute.name,
                                path: 'sent-requests-page',
                                parent: ContactsWrapper.name)
                          ]),
                      _i24.RouteConfig(NotificationsRoute.name,
                          path: 'notifications-page', parent: HomeRoute.name),
                      _i24.RouteConfig(ProfileWrapper.name,
                          path: 'profile-wrapper',
                          parent: HomeRoute.name,
                          children: [
                            _i24.RouteConfig(ProfileRoute.name,
                                path: 'profile-page',
                                parent: ProfileWrapper.name),
                            _i24.RouteConfig(EditProfileRoute.name,
                                path: 'edit-profile-page',
                                parent: ProfileWrapper.name),
                            _i24.RouteConfig(PreferencesRoute.name,
                                path: 'preferences-page',
                                parent: ProfileWrapper.name)
                          ])
                    ]),
                _i24.RouteConfig(ContactProfileRoute.name,
                    path: 'contact-profile-page', parent: HomeWrapper.name)
              ]),
          _i24.RouteConfig(LoginWrapper.name,
              path: 'login-wrapper',
              parent: RootWrapper.name,
              children: [
                _i24.RouteConfig(LoginRoute.name,
                    path: 'login-page', parent: LoginWrapper.name),
                _i24.RouteConfig(PhoneValidationRoute.name,
                    path: 'phone-validation-page', parent: LoginWrapper.name),
                _i24.RouteConfig(LoadingRoute.name,
                    path: 'loading-page', parent: LoginWrapper.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.RootWrapper]
class RootWrapper extends _i24.PageRouteInfo<RootWrapperArgs> {
  RootWrapper({_i25.Key? key, List<_i24.PageRouteInfo>? children})
      : super(RootWrapper.name,
            path: '/',
            args: RootWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'RootWrapper';
}

class RootWrapperArgs {
  const RootWrapperArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'RootWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.OnBoardingWrapper]
class OnBoardingWrapper extends _i24.PageRouteInfo<OnBoardingWrapperArgs> {
  OnBoardingWrapper({_i25.Key? key, List<_i24.PageRouteInfo>? children})
      : super(OnBoardingWrapper.name,
            path: 'on-boarding-wrapper',
            args: OnBoardingWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'OnBoardingWrapper';
}

class OnBoardingWrapperArgs {
  const OnBoardingWrapperArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'OnBoardingWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.HomeWrapper]
class HomeWrapper extends _i24.PageRouteInfo<HomeWrapperArgs> {
  HomeWrapper({_i25.Key? key, List<_i24.PageRouteInfo>? children})
      : super(HomeWrapper.name,
            path: 'home-wrapper',
            args: HomeWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeWrapper';
}

class HomeWrapperArgs {
  const HomeWrapperArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'HomeWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.LoginWrapper]
class LoginWrapper extends _i24.PageRouteInfo<LoginWrapperArgs> {
  LoginWrapper({_i25.Key? key, List<_i24.PageRouteInfo>? children})
      : super(LoginWrapper.name,
            path: 'login-wrapper',
            args: LoginWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'LoginWrapper';
}

class LoginWrapperArgs {
  const LoginWrapperArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'LoginWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.OnBoardingPage]
class OnBoardingRoute extends _i24.PageRouteInfo<OnBoardingRouteArgs> {
  OnBoardingRoute({_i25.Key? key})
      : super(OnBoardingRoute.name,
            path: 'on-boarding-page', args: OnBoardingRouteArgs(key: key));

  static const String name = 'OnBoardingRoute';
}

class OnBoardingRouteArgs {
  const OnBoardingRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'OnBoardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.ProgressOnboardingPage]
class ProgressOnboardingRoute
    extends _i24.PageRouteInfo<ProgressOnboardingRouteArgs> {
  ProgressOnboardingRoute({_i25.Key? key})
      : super(ProgressOnboardingRoute.name,
            path: 'progress-onboarding-page',
            args: ProgressOnboardingRouteArgs(key: key));

  static const String name = 'ProgressOnboardingRoute';
}

class ProgressOnboardingRouteArgs {
  const ProgressOnboardingRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'ProgressOnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i24.PageRouteInfo<void> {
  const HomeRoute({List<_i24.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i8.ContactProfilePage]
class ContactProfileRoute extends _i24.PageRouteInfo<ContactProfileRouteArgs> {
  ContactProfileRoute(
      {required _i26.Contact contact,
      required String navigationSource,
      _i27.ContactProfileController? controller,
      _i25.Key? key})
      : super(ContactProfileRoute.name,
            path: 'contact-profile-page',
            args: ContactProfileRouteArgs(
                contact: contact,
                navigationSource: navigationSource,
                controller: controller,
                key: key));

  static const String name = 'ContactProfileRoute';
}

class ContactProfileRouteArgs {
  const ContactProfileRouteArgs(
      {required this.contact,
      required this.navigationSource,
      this.controller,
      this.key});

  final _i26.Contact contact;

  final String navigationSource;

  final _i27.ContactProfileController? controller;

  final _i25.Key? key;

  @override
  String toString() {
    return 'ContactProfileRouteArgs{contact: $contact, navigationSource: $navigationSource, controller: $controller, key: $key}';
  }
}

/// generated route for
/// [_i9.HomeMapPage]
class HomeMapRoute extends _i24.PageRouteInfo<HomeMapRouteArgs> {
  HomeMapRoute({_i28.MapController? controller, _i25.Key? key})
      : super(HomeMapRoute.name,
            path: 'home-map-page',
            args: HomeMapRouteArgs(controller: controller, key: key));

  static const String name = 'HomeMapRoute';
}

class HomeMapRouteArgs {
  const HomeMapRouteArgs({this.controller, this.key});

  final _i28.MapController? controller;

  final _i25.Key? key;

  @override
  String toString() {
    return 'HomeMapRouteArgs{controller: $controller, key: $key}';
  }
}

/// generated route for
/// [_i10.ContactsWrapper]
class ContactsWrapper extends _i24.PageRouteInfo<ContactsWrapperArgs> {
  ContactsWrapper({_i25.Key? key, List<_i24.PageRouteInfo>? children})
      : super(ContactsWrapper.name,
            path: 'contacts-wrapper',
            args: ContactsWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'ContactsWrapper';
}

class ContactsWrapperArgs {
  const ContactsWrapperArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'ContactsWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.NotificationsPage]
class NotificationsRoute extends _i24.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i12.ProfileWrapper]
class ProfileWrapper extends _i24.PageRouteInfo<ProfileWrapperArgs> {
  ProfileWrapper({_i25.Key? key, List<_i24.PageRouteInfo>? children})
      : super(ProfileWrapper.name,
            path: 'profile-wrapper',
            args: ProfileWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'ProfileWrapper';
}

class ProfileWrapperArgs {
  const ProfileWrapperArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'ProfileWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.ContactsPage]
class ContactsRoute extends _i24.PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({_i25.Key? key, List<_i24.PageRouteInfo>? children})
      : super(ContactsRoute.name,
            path: 'contacts-page',
            args: ContactsRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.SentRequestsPage]
class SentRequestsRoute extends _i24.PageRouteInfo<SentRequestsRouteArgs> {
  SentRequestsRoute({_i25.Key? key})
      : super(SentRequestsRoute.name,
            path: 'sent-requests-page', args: SentRequestsRouteArgs(key: key));

  static const String name = 'SentRequestsRoute';
}

class SentRequestsRouteArgs {
  const SentRequestsRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'SentRequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.FriendsPage]
class FriendsRoute extends _i24.PageRouteInfo<FriendsRouteArgs> {
  FriendsRoute({_i25.Key? key})
      : super(FriendsRoute.name,
            path: 'friends-page', args: FriendsRouteArgs(key: key));

  static const String name = 'FriendsRoute';
}

class FriendsRouteArgs {
  const FriendsRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'FriendsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.RequestsPage]
class RequestsRoute extends _i24.PageRouteInfo<RequestsRouteArgs> {
  RequestsRoute({_i25.Key? key})
      : super(RequestsRoute.name,
            path: 'requests-page', args: RequestsRouteArgs(key: key));

  static const String name = 'RequestsRoute';
}

class RequestsRouteArgs {
  const RequestsRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'RequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.SuggestionsPage]
class SuggestionsRoute extends _i24.PageRouteInfo<SuggestionsRouteArgs> {
  SuggestionsRoute({_i25.Key? key})
      : super(SuggestionsRoute.name,
            path: 'suggestions-page', args: SuggestionsRouteArgs(key: key));

  static const String name = 'SuggestionsRoute';
}

class SuggestionsRouteArgs {
  const SuggestionsRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'SuggestionsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.ProfilePage]
class ProfileRoute extends _i24.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i25.Key? key})
      : super(ProfileRoute.name,
            path: 'profile-page', args: ProfileRouteArgs(key: key));

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.EditProfilePage]
class EditProfileRoute extends _i24.PageRouteInfo<void> {
  const EditProfileRoute()
      : super(EditProfileRoute.name, path: 'edit-profile-page');

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [_i20.PreferencesPage]
class PreferencesRoute extends _i24.PageRouteInfo<void> {
  const PreferencesRoute()
      : super(PreferencesRoute.name, path: 'preferences-page');

  static const String name = 'PreferencesRoute';
}

/// generated route for
/// [_i21.LoginPage]
class LoginRoute extends _i24.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i22.PhoneValidationPage]
class PhoneValidationRoute extends _i24.PageRouteInfo<void> {
  const PhoneValidationRoute()
      : super(PhoneValidationRoute.name, path: 'phone-validation-page');

  static const String name = 'PhoneValidationRoute';
}

/// generated route for
/// [_i23.LoadingPage]
class LoadingRoute extends _i24.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: 'loading-page');

  static const String name = 'LoadingRoute';
}
