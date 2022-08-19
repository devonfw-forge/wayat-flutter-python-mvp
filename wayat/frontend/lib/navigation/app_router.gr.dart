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
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/material.dart' as _i26;

import '../features/authentication/page/loading_page.dart' as _i24;
import '../features/authentication/page/login_page.dart' as _i22;
import '../features/authentication/page/login_wrapper.dart' as _i4;
import '../features/authentication/page/phone_validation_page.dart' as _i23;
import '../features/contacts/pages/contacts_page/contacts_page.dart' as _i12;
import '../features/contacts/pages/contacts_page/friends_page/friends_page.dart'
    as _i14;
import '../features/contacts/pages/contacts_page/requests_page/requests_page.dart'
    as _i15;
import '../features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart'
    as _i16;
import '../features/contacts/pages/contacts_wrapper.dart' as _i9;
import '../features/contacts/pages/sent_requests_page/sent_requests_page.dart'
    as _i13;
import '../features/create_event/page/create_event_page.dart' as _i8;
import '../features/home/pages/home_page.dart' as _i3;
import '../features/map/page/home_map_page.dart' as _i7;
import '../features/notifications/page/notifications_page.dart' as _i10;
import '../features/onboarding/pages/onboarding_page.dart' as _i5;
import '../features/onboarding/pages/onboarding_wrapper.dart' as _i2;
import '../features/onboarding/pages/progress_page.dart' as _i6;
import '../features/profile/pages/faq/faqs.dart' as _i20;
import '../features/profile/pages/preferences/preferences.dart' as _i19;
import '../features/profile/pages/privacy/privacy.dart' as _i21;
import '../features/profile/pages/profile/edit_profile.dart' as _i18;
import '../features/profile/pages/profile/profile.dart' as _i17;
import '../features/profile/pages/profile/profile_wraper.dart' as _i11;
import '../features/root/root_wrapper.dart' as _i1;

class AppRouter extends _i25.RootStackRouter {
  AppRouter([_i26.GlobalKey<_i26.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i25.PageFactory> pagesMap = {
    RootWrapper.name: (routeData) {
      final args = routeData.argsAs<RootWrapperArgs>(
          orElse: () => const RootWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.RootWrapper(key: args.key));
    },
    OnBoardingWrapper.name: (routeData) {
      final args = routeData.argsAs<OnBoardingWrapperArgs>(
          orElse: () => const OnBoardingWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.OnBoardingWrapper(key: args.key));
    },
    HomeRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePage());
    },
    LoginWrapper.name: (routeData) {
      final args = routeData.argsAs<LoginWrapperArgs>(
          orElse: () => const LoginWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.LoginWrapper(key: args.key));
    },
    OnBoardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingRouteArgs>(
          orElse: () => const OnBoardingRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.OnBoardingPage(key: args.key));
    },
    ProgressOnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressOnboardingRouteArgs>(
          orElse: () => const ProgressOnboardingRouteArgs());
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: _i6.ProgressOnboardingPage(key: args.key),
          transitionsBuilder: _i25.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HomeMapRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMapRouteArgs>(
          orElse: () => const HomeMapRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.HomeMapPage(key: args.key));
    },
    CreateEventRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CreateEventPage());
    },
    ContactsWrapper.name: (routeData) {
      final args = routeData.argsAs<ContactsWrapperArgs>(
          orElse: () => const ContactsWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.ContactsWrapper(key: args.key));
    },
    NotificationsRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.NotificationsPage());
    },
    ProfileWrapper.name: (routeData) {
      final args = routeData.argsAs<ProfileWrapperArgs>(
          orElse: () => const ProfileWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i11.ProfileWrapper(key: args.key));
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.ContactsPage(key: args.key));
    },
    SentRequestsRoute.name: (routeData) {
      final args = routeData.argsAs<SentRequestsRouteArgs>(
          orElse: () => const SentRequestsRouteArgs());
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: _i13.SentRequestsPage(key: args.key),
          transitionsBuilder: _i25.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    FriendsRoute.name: (routeData) {
      final args = routeData.argsAs<FriendsRouteArgs>(
          orElse: () => const FriendsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.FriendsPage(key: args.key));
    },
    RequestsRoute.name: (routeData) {
      final args = routeData.argsAs<RequestsRouteArgs>(
          orElse: () => const RequestsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i15.RequestsPage(key: args.key));
    },
    SuggestionsRoute.name: (routeData) {
      final args = routeData.argsAs<SuggestionsRouteArgs>(
          orElse: () => const SuggestionsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i16.SuggestionsPage(key: args.key));
    },
    ProfileRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.ProfilePage());
    },
    EditProfileRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.EditProfilePage());
    },
    PreferencesRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.PreferencesPage());
    },
    FaqsRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i20.FaqsPage());
    },
    PrivacyRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.PrivacyPage());
    },
    LoginRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i22.LoginPage());
    },
    PhoneValidationRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.PhoneValidationPage());
    },
    LoadingRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i24.LoadingPage());
    }
  };

  @override
  List<_i25.RouteConfig> get routes => [
        _i25.RouteConfig(RootWrapper.name, path: '/', children: [
          _i25.RouteConfig(OnBoardingWrapper.name,
              path: 'on-boarding-wrapper',
              parent: RootWrapper.name,
              children: [
                _i25.RouteConfig(OnBoardingRoute.name,
                    path: 'on-boarding-page', parent: OnBoardingWrapper.name),
                _i25.RouteConfig(ProgressOnboardingRoute.name,
                    path: 'progress-onboarding-page',
                    parent: OnBoardingWrapper.name)
              ]),
          _i25.RouteConfig(HomeRoute.name,
              path: 'home-page',
              parent: RootWrapper.name,
              children: [
                _i25.RouteConfig(HomeMapRoute.name,
                    path: 'home-map-page', parent: HomeRoute.name),
                _i25.RouteConfig(CreateEventRoute.name,
                    path: 'create-event-page', parent: HomeRoute.name),
                _i25.RouteConfig(ContactsWrapper.name,
                    path: 'contacts-wrapper',
                    parent: HomeRoute.name,
                    children: [
                      _i25.RouteConfig(ContactsRoute.name,
                          path: 'contacts-page',
                          parent: ContactsWrapper.name,
                          children: [
                            _i25.RouteConfig(FriendsRoute.name,
                                path: 'friends-page',
                                parent: ContactsRoute.name),
                            _i25.RouteConfig(RequestsRoute.name,
                                path: 'requests-page',
                                parent: ContactsRoute.name),
                            _i25.RouteConfig(SuggestionsRoute.name,
                                path: 'suggestions-page',
                                parent: ContactsRoute.name)
                          ]),
                      _i25.RouteConfig(SentRequestsRoute.name,
                          path: 'sent-requests-page',
                          parent: ContactsWrapper.name)
                    ]),
                _i25.RouteConfig(NotificationsRoute.name,
                    path: 'notifications-page', parent: HomeRoute.name),
                _i25.RouteConfig(ProfileWrapper.name,
                    path: 'profile-wrapper',
                    parent: HomeRoute.name,
                    children: [
                      _i25.RouteConfig(ProfileRoute.name,
                          path: 'profile-page', parent: ProfileWrapper.name),
                      _i25.RouteConfig(EditProfileRoute.name,
                          path: 'edit-profile-page',
                          parent: ProfileWrapper.name),
                      _i25.RouteConfig(PreferencesRoute.name,
                          path: 'preferences-page',
                          parent: ProfileWrapper.name),
                      _i25.RouteConfig(FaqsRoute.name,
                          path: 'faqs-page', parent: ProfileWrapper.name),
                      _i25.RouteConfig(PrivacyRoute.name,
                          path: 'privacy-page', parent: ProfileWrapper.name)
                    ])
              ]),
          _i25.RouteConfig(LoginWrapper.name,
              path: 'login-wrapper',
              parent: RootWrapper.name,
              children: [
                _i25.RouteConfig(LoginRoute.name,
                    path: 'login-page', parent: LoginWrapper.name),
                _i25.RouteConfig(PhoneValidationRoute.name,
                    path: 'phone-validation-page', parent: LoginWrapper.name),
                _i25.RouteConfig(LoadingRoute.name,
                    path: 'loading-page', parent: LoginWrapper.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.RootWrapper]
class RootWrapper extends _i25.PageRouteInfo<RootWrapperArgs> {
  RootWrapper({_i26.Key? key, List<_i25.PageRouteInfo>? children})
      : super(RootWrapper.name,
            path: '/',
            args: RootWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'RootWrapper';
}

class RootWrapperArgs {
  const RootWrapperArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'RootWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.OnBoardingWrapper]
class OnBoardingWrapper extends _i25.PageRouteInfo<OnBoardingWrapperArgs> {
  OnBoardingWrapper({_i26.Key? key, List<_i25.PageRouteInfo>? children})
      : super(OnBoardingWrapper.name,
            path: 'on-boarding-wrapper',
            args: OnBoardingWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'OnBoardingWrapper';
}

class OnBoardingWrapperArgs {
  const OnBoardingWrapperArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'OnBoardingWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i25.PageRouteInfo<void> {
  const HomeRoute({List<_i25.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LoginWrapper]
class LoginWrapper extends _i25.PageRouteInfo<LoginWrapperArgs> {
  LoginWrapper({_i26.Key? key, List<_i25.PageRouteInfo>? children})
      : super(LoginWrapper.name,
            path: 'login-wrapper',
            args: LoginWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'LoginWrapper';
}

class LoginWrapperArgs {
  const LoginWrapperArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'LoginWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.OnBoardingPage]
class OnBoardingRoute extends _i25.PageRouteInfo<OnBoardingRouteArgs> {
  OnBoardingRoute({_i26.Key? key})
      : super(OnBoardingRoute.name,
            path: 'on-boarding-page', args: OnBoardingRouteArgs(key: key));

  static const String name = 'OnBoardingRoute';
}

class OnBoardingRouteArgs {
  const OnBoardingRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'OnBoardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.ProgressOnboardingPage]
class ProgressOnboardingRoute
    extends _i25.PageRouteInfo<ProgressOnboardingRouteArgs> {
  ProgressOnboardingRoute({_i26.Key? key})
      : super(ProgressOnboardingRoute.name,
            path: 'progress-onboarding-page',
            args: ProgressOnboardingRouteArgs(key: key));

  static const String name = 'ProgressOnboardingRoute';
}

class ProgressOnboardingRouteArgs {
  const ProgressOnboardingRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'ProgressOnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.HomeMapPage]
class HomeMapRoute extends _i25.PageRouteInfo<HomeMapRouteArgs> {
  HomeMapRoute({_i26.Key? key})
      : super(HomeMapRoute.name,
            path: 'home-map-page', args: HomeMapRouteArgs(key: key));

  static const String name = 'HomeMapRoute';
}

class HomeMapRouteArgs {
  const HomeMapRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'HomeMapRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.CreateEventPage]
class CreateEventRoute extends _i25.PageRouteInfo<void> {
  const CreateEventRoute()
      : super(CreateEventRoute.name, path: 'create-event-page');

  static const String name = 'CreateEventRoute';
}

/// generated route for
/// [_i9.ContactsWrapper]
class ContactsWrapper extends _i25.PageRouteInfo<ContactsWrapperArgs> {
  ContactsWrapper({_i26.Key? key, List<_i25.PageRouteInfo>? children})
      : super(ContactsWrapper.name,
            path: 'contacts-wrapper',
            args: ContactsWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'ContactsWrapper';
}

class ContactsWrapperArgs {
  const ContactsWrapperArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'ContactsWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.NotificationsPage]
class NotificationsRoute extends _i25.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i11.ProfileWrapper]
class ProfileWrapper extends _i25.PageRouteInfo<ProfileWrapperArgs> {
  ProfileWrapper({_i26.Key? key, List<_i25.PageRouteInfo>? children})
      : super(ProfileWrapper.name,
            path: 'profile-wrapper',
            args: ProfileWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'ProfileWrapper';
}

class ProfileWrapperArgs {
  const ProfileWrapperArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'ProfileWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.ContactsPage]
class ContactsRoute extends _i25.PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({_i26.Key? key, List<_i25.PageRouteInfo>? children})
      : super(ContactsRoute.name,
            path: 'contacts-page',
            args: ContactsRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.SentRequestsPage]
class SentRequestsRoute extends _i25.PageRouteInfo<SentRequestsRouteArgs> {
  SentRequestsRoute({_i26.Key? key})
      : super(SentRequestsRoute.name,
            path: 'sent-requests-page', args: SentRequestsRouteArgs(key: key));

  static const String name = 'SentRequestsRoute';
}

class SentRequestsRouteArgs {
  const SentRequestsRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'SentRequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.FriendsPage]
class FriendsRoute extends _i25.PageRouteInfo<FriendsRouteArgs> {
  FriendsRoute({_i26.Key? key})
      : super(FriendsRoute.name,
            path: 'friends-page', args: FriendsRouteArgs(key: key));

  static const String name = 'FriendsRoute';
}

class FriendsRouteArgs {
  const FriendsRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'FriendsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.RequestsPage]
class RequestsRoute extends _i25.PageRouteInfo<RequestsRouteArgs> {
  RequestsRoute({_i26.Key? key})
      : super(RequestsRoute.name,
            path: 'requests-page', args: RequestsRouteArgs(key: key));

  static const String name = 'RequestsRoute';
}

class RequestsRouteArgs {
  const RequestsRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'RequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.SuggestionsPage]
class SuggestionsRoute extends _i25.PageRouteInfo<SuggestionsRouteArgs> {
  SuggestionsRoute({_i26.Key? key})
      : super(SuggestionsRoute.name,
            path: 'suggestions-page', args: SuggestionsRouteArgs(key: key));

  static const String name = 'SuggestionsRoute';
}

class SuggestionsRouteArgs {
  const SuggestionsRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'SuggestionsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.ProfilePage]
class ProfileRoute extends _i25.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile-page');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i18.EditProfilePage]
class EditProfileRoute extends _i25.PageRouteInfo<void> {
  const EditProfileRoute()
      : super(EditProfileRoute.name, path: 'edit-profile-page');

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [_i19.PreferencesPage]
class PreferencesRoute extends _i25.PageRouteInfo<void> {
  const PreferencesRoute()
      : super(PreferencesRoute.name, path: 'preferences-page');

  static const String name = 'PreferencesRoute';
}

/// generated route for
/// [_i20.FaqsPage]
class FaqsRoute extends _i25.PageRouteInfo<void> {
  const FaqsRoute() : super(FaqsRoute.name, path: 'faqs-page');

  static const String name = 'FaqsRoute';
}

/// generated route for
/// [_i21.PrivacyPage]
class PrivacyRoute extends _i25.PageRouteInfo<void> {
  const PrivacyRoute() : super(PrivacyRoute.name, path: 'privacy-page');

  static const String name = 'PrivacyRoute';
}

/// generated route for
/// [_i22.LoginPage]
class LoginRoute extends _i25.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i23.PhoneValidationPage]
class PhoneValidationRoute extends _i25.PageRouteInfo<void> {
  const PhoneValidationRoute()
      : super(PhoneValidationRoute.name, path: 'phone-validation-page');

  static const String name = 'PhoneValidationRoute';
}

/// generated route for
/// [_i24.LoadingPage]
class LoadingRoute extends _i25.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: 'loading-page');

  static const String name = 'LoadingRoute';
}
