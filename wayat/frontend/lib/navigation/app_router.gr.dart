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

import '../domain/contact/contact.dart' as _i27;
import '../features/authentication/page/loading_page.dart' as _i20;
import '../features/authentication/page/login_page.dart' as _i18;
import '../features/authentication/page/login_wrapper.dart' as _i6;
import '../features/authentication/page/phone_validation_page.dart' as _i19;
import '../features/contacts/pages/contact_detail_page.dart' as _i2;
import '../features/contacts/pages/contacts_page/contacts_page.dart' as _i13;
import '../features/contacts/pages/contacts_page/friends_page/friends_page.dart'
    as _i15;
import '../features/contacts/pages/contacts_page/requests_page/requests_page.dart'
    as _i16;
import '../features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart'
    as _i17;
import '../features/contacts/pages/contacts_wrapper.dart' as _i11;
import '../features/contacts/pages/sent_requests_page/sent_requests_page.dart'
    as _i14;
import '../features/create_event/page/create_event_page.dart' as _i10;
import '../features/home/pages/home_page.dart' as _i5;
import '../features/map/page/home_map_page.dart' as _i9;
import '../features/notifications/page/notifications_page.dart' as _i12;
import '../features/onboarding/pages/onboarding_page.dart' as _i7;
import '../features/onboarding/pages/onboarding_wrapper.dart' as _i4;
import '../features/onboarding/pages/progress_page.dart' as _i8;
import '../features/profile/pages/faq/faqs.dart' as _i23;
import '../features/profile/pages/preferences/preferences.dart' as _i22;
import '../features/profile/pages/profile/edit_profile.dart' as _i21;
import '../features/profile/pages/profile/profile.dart' as _i3;
import '../features/profile/pages/terms/terms.dart' as _i24;
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
    ContactDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ContactDetailRouteArgs>();
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.ContactDetailPage(key: args.key, contact: args.contact));
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProfilePage(key: args.key, contact: args.contact));
    },
    OnBoardingWrapper.name: (routeData) {
      final args = routeData.argsAs<OnBoardingWrapperArgs>(
          orElse: () => const OnBoardingWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.OnBoardingWrapper(key: args.key));
    },
    HomeRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.HomePage());
    },
    LoginWrapper.name: (routeData) {
      final args = routeData.argsAs<LoginWrapperArgs>(
          orElse: () => const LoginWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.LoginWrapper(key: args.key));
    },
    OnBoardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingRouteArgs>(
          orElse: () => const OnBoardingRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.OnBoardingPage(key: args.key));
    },
    ProgressOnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressOnboardingRouteArgs>(
          orElse: () => const ProgressOnboardingRouteArgs());
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: _i8.ProgressOnboardingPage(key: args.key),
          transitionsBuilder: _i25.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HomeMapRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMapRouteArgs>(
          orElse: () => const HomeMapRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.HomeMapPage(key: args.key));
    },
    CreateEventRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.CreateEventPage());
    },
    ContactsWrapper.name: (routeData) {
      final args = routeData.argsAs<ContactsWrapperArgs>(
          orElse: () => const ContactsWrapperArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i11.ContactsWrapper(key: args.key));
    },
    NotificationsRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.NotificationsPage());
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.ContactsPage(key: args.key));
    },
    SentRequestsRoute.name: (routeData) {
      final args = routeData.argsAs<SentRequestsRouteArgs>(
          orElse: () => const SentRequestsRouteArgs());
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: _i14.SentRequestsPage(key: args.key),
          transitionsBuilder: _i25.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    FriendsRoute.name: (routeData) {
      final args = routeData.argsAs<FriendsRouteArgs>(
          orElse: () => const FriendsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i15.FriendsPage(key: args.key));
    },
    RequestsRoute.name: (routeData) {
      final args = routeData.argsAs<RequestsRouteArgs>(
          orElse: () => const RequestsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i16.RequestsPage(key: args.key));
    },
    SuggestionsRoute.name: (routeData) {
      final args = routeData.argsAs<SuggestionsRouteArgs>(
          orElse: () => const SuggestionsRouteArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: _i17.SuggestionsPage(key: args.key));
    },
    LoginRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.LoginPage());
    },
    PhoneValidationRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.PhoneValidationPage());
    },
    LoadingRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i20.LoadingPage());
    },
    EditProfileRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.EditProfilePage());
    },
    PreferencesRoute.name: (routeData) {
      final args = routeData.argsAs<PreferencesRouteArgs>();
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i22.PreferencesPage(key: args.key, contact: args.contact));
    },
    FaqsRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.FaqsPage());
    },
    TermsRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i24.TermsPage());
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
                    path: 'notifications-page', parent: HomeRoute.name)
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
        ]),
        _i25.RouteConfig(ContactDetailRoute.name, path: '/contact-detail-page'),
        _i25.RouteConfig(ProfileRoute.name, path: '/profile-page', children: [
          _i25.RouteConfig(EditProfileRoute.name,
              path: 'edit-profile-page', parent: ProfileRoute.name),
          _i25.RouteConfig(PreferencesRoute.name,
              path: 'preferences-page', parent: ProfileRoute.name),
          _i25.RouteConfig(FaqsRoute.name,
              path: 'faqs-page', parent: ProfileRoute.name),
          _i25.RouteConfig(TermsRoute.name,
              path: 'terms-page', parent: ProfileRoute.name)
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
/// [_i2.ContactDetailPage]
class ContactDetailRoute extends _i25.PageRouteInfo<ContactDetailRouteArgs> {
  ContactDetailRoute({_i26.Key? key, required _i27.Contact contact})
      : super(ContactDetailRoute.name,
            path: '/contact-detail-page',
            args: ContactDetailRouteArgs(key: key, contact: contact));

  static const String name = 'ContactDetailRoute';
}

class ContactDetailRouteArgs {
  const ContactDetailRouteArgs({this.key, required this.contact});

  final _i26.Key? key;

  final _i27.Contact contact;

  @override
  String toString() {
    return 'ContactDetailRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [_i3.ProfilePage]
class ProfileRoute extends _i25.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute(
      {_i26.Key? key,
      required _i27.Contact contact,
      List<_i25.PageRouteInfo>? children})
      : super(ProfileRoute.name,
            path: '/profile-page',
            args: ProfileRouteArgs(key: key, contact: contact),
            initialChildren: children);

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key, required this.contact});

  final _i26.Key? key;

  final _i27.Contact contact;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [_i4.OnBoardingWrapper]
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
/// [_i5.HomePage]
class HomeRoute extends _i25.PageRouteInfo<void> {
  const HomeRoute({List<_i25.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i6.LoginWrapper]
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
/// [_i7.OnBoardingPage]
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
/// [_i8.ProgressOnboardingPage]
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
/// [_i9.HomeMapPage]
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
/// [_i10.CreateEventPage]
class CreateEventRoute extends _i25.PageRouteInfo<void> {
  const CreateEventRoute()
      : super(CreateEventRoute.name, path: 'create-event-page');

  static const String name = 'CreateEventRoute';
}

/// generated route for
/// [_i11.ContactsWrapper]
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
/// [_i12.NotificationsPage]
class NotificationsRoute extends _i25.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i13.ContactsPage]
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
/// [_i14.SentRequestsPage]
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
/// [_i15.FriendsPage]
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
/// [_i16.RequestsPage]
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
/// [_i17.SuggestionsPage]
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
/// [_i18.LoginPage]
class LoginRoute extends _i25.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i19.PhoneValidationPage]
class PhoneValidationRoute extends _i25.PageRouteInfo<void> {
  const PhoneValidationRoute()
      : super(PhoneValidationRoute.name, path: 'phone-validation-page');

  static const String name = 'PhoneValidationRoute';
}

/// generated route for
/// [_i20.LoadingPage]
class LoadingRoute extends _i25.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: 'loading-page');

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i21.EditProfilePage]
class EditProfileRoute extends _i25.PageRouteInfo<void> {
  const EditProfileRoute()
      : super(EditProfileRoute.name, path: 'edit-profile-page');

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [_i22.PreferencesPage]
class PreferencesRoute extends _i25.PageRouteInfo<PreferencesRouteArgs> {
  PreferencesRoute({_i26.Key? key, required _i27.Contact contact})
      : super(PreferencesRoute.name,
            path: 'preferences-page',
            args: PreferencesRouteArgs(key: key, contact: contact));

  static const String name = 'PreferencesRoute';
}

class PreferencesRouteArgs {
  const PreferencesRouteArgs({this.key, required this.contact});

  final _i26.Key? key;

  final _i27.Contact contact;

  @override
  String toString() {
    return 'PreferencesRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [_i23.FaqsPage]
class FaqsRoute extends _i25.PageRouteInfo<void> {
  const FaqsRoute() : super(FaqsRoute.name, path: 'faqs-page');

  static const String name = 'FaqsRoute';
}

/// generated route for
/// [_i24.TermsPage]
class TermsRoute extends _i25.PageRouteInfo<void> {
  const TermsRoute() : super(TermsRoute.name, path: 'terms-page');

  static const String name = 'TermsRoute';
}
