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
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:flutter/material.dart' as _i31;

import '../domain/contact/contact.dart' as _i32;
import '../domain/group/group.dart' as _i36;
import '../features/authentication/page/loading_page.dart' as _i29;
import '../features/authentication/page/login_page.dart' as _i27;
import '../features/authentication/page/login_wrapper.dart' as _i4;
import '../features/authentication/page/phone_validation_page.dart' as _i28;
import '../features/contact_profile/controller/contact_profile_controller.dart'
    as _i33;
import '../features/contact_profile/page/contact_profile_page.dart' as _i8;
import '../features/contacts/pages/contacts_page/contacts_page.dart' as _i13;
import '../features/contacts/pages/contacts_page/friends_page/friends_page.dart'
    as _i16;
import '../features/contacts/pages/contacts_page/requests_page/requests_page.dart'
    as _i17;
import '../features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart'
    as _i18;
import '../features/contacts/pages/contacts_wrapper.dart' as _i10;
import '../features/contacts/pages/sent_requests_page/sent_requests_page.dart'
    as _i14;
import '../features/groups/controllers/manage_group_controller/manage_group_controller.dart'
    as _i35;
import '../features/groups/pages/groups_page.dart' as _i19;
import '../features/groups/pages/groups_wrapper.dart' as _i15;
import '../features/groups/pages/manage_group_page.dart' as _i20;
import '../features/groups/pages/view_group_page.dart' as _i21;
import '../features/home/pages/home_page.dart' as _i7;
import '../features/home/pages/home_wrapper.dart' as _i3;
import '../features/map/controller/map_controller.dart' as _i34;
import '../features/map/page/home_map_page.dart' as _i9;
import '../features/notifications/page/notifications_page.dart' as _i11;
import '../features/onboarding/pages/onboarding_page.dart' as _i5;
import '../features/onboarding/pages/onboarding_wrapper.dart' as _i2;
import '../features/onboarding/pages/progress_page.dart' as _i6;
import '../features/profile/pages/edit_profile_page/edit_profile_page.dart'
    as _i23;
import '../features/profile/pages/faqs_page/faqs_page.dart' as _i25;
import '../features/profile/pages/preferences_page/preferences_page.dart'
    as _i24;
import '../features/profile/pages/privacy_page/privacy_page.dart' as _i26;
import '../features/profile/pages/profile_page.dart' as _i22;
import '../features/profile/pages/profile_wraper.dart' as _i12;
import '../features/root/root_wrapper.dart' as _i1;

class AppRouter extends _i30.RootStackRouter {
  AppRouter([_i31.GlobalKey<_i31.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i30.PageFactory> pagesMap = {
    RootWrapper.name: (routeData) {
      final args = routeData.argsAs<RootWrapperArgs>(
          orElse: () => const RootWrapperArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.RootWrapper(key: args.key));
    },
    OnBoardingWrapper.name: (routeData) {
      final args = routeData.argsAs<OnBoardingWrapperArgs>(
          orElse: () => const OnBoardingWrapperArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.OnBoardingWrapper(key: args.key));
    },
    HomeWrapper.name: (routeData) {
      final args = routeData.argsAs<HomeWrapperArgs>(
          orElse: () => const HomeWrapperArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.HomeWrapper(key: args.key));
    },
    LoginWrapper.name: (routeData) {
      final args = routeData.argsAs<LoginWrapperArgs>(
          orElse: () => const LoginWrapperArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.LoginWrapper(key: args.key));
    },
    OnBoardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingRouteArgs>(
          orElse: () => const OnBoardingRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.OnBoardingPage(key: args.key));
    },
    ProgressOnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressOnboardingRouteArgs>(
          orElse: () => const ProgressOnboardingRouteArgs());
      return _i30.CustomPage<dynamic>(
          routeData: routeData,
          child: _i6.ProgressOnboardingPage(key: args.key),
          transitionsBuilder: _i30.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HomeRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.HomePage());
    },
    ContactProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ContactProfileRouteArgs>();
      return _i30.MaterialPageX<dynamic>(
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
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.HomeMapPage(controller: args.controller, key: args.key));
    },
    ContactsWrapper.name: (routeData) {
      final args = routeData.argsAs<ContactsWrapperArgs>(
          orElse: () => const ContactsWrapperArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.ContactsWrapper(key: args.key));
    },
    NotificationsRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.NotificationsPage());
    },
    ProfileWrapper.name: (routeData) {
      final args = routeData.argsAs<ProfileWrapperArgs>(
          orElse: () => const ProfileWrapperArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.ProfileWrapper(key: args.key));
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.ContactsPage(key: args.key));
    },
    SentRequestsRoute.name: (routeData) {
      final args = routeData.argsAs<SentRequestsRouteArgs>(
          orElse: () => const SentRequestsRouteArgs());
      return _i30.CustomPage<dynamic>(
          routeData: routeData,
          child: _i14.SentRequestsPage(key: args.key),
          transitionsBuilder: _i30.TransitionsBuilders.slideLeftWithFade,
          opaque: true,
          barrierDismissible: false);
    },
    GroupsWrapper.name: (routeData) {
      final args = routeData.argsAs<GroupsWrapperArgs>(
          orElse: () => const GroupsWrapperArgs());
      return _i30.CustomPage<dynamic>(
          routeData: routeData,
          child: _i15.GroupsWrapper(key: args.key),
          transitionsBuilder: _i30.TransitionsBuilders.slideLeftWithFade,
          opaque: true,
          barrierDismissible: false);
    },
    FriendsRoute.name: (routeData) {
      final args = routeData.argsAs<FriendsRouteArgs>(
          orElse: () => const FriendsRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i16.FriendsPage(key: args.key));
    },
    RequestsRoute.name: (routeData) {
      final args = routeData.argsAs<RequestsRouteArgs>(
          orElse: () => const RequestsRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i17.RequestsPage(key: args.key));
    },
    SuggestionsRoute.name: (routeData) {
      final args = routeData.argsAs<SuggestionsRouteArgs>(
          orElse: () => const SuggestionsRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i18.SuggestionsPage(key: args.key));
    },
    GroupsRoute.name: (routeData) {
      final args = routeData.argsAs<GroupsRouteArgs>(
          orElse: () => const GroupsRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i19.GroupsPage(key: args.key));
    },
    ManageGroupRoute.name: (routeData) {
      final args = routeData.argsAs<ManageGroupRouteArgs>(
          orElse: () => const ManageGroupRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i20.ManageGroupPage(
              controller: args.controller, group: args.group, key: args.key));
    },
    ViewGroupRoute.name: (routeData) {
      final args = routeData.argsAs<ViewGroupRouteArgs>(
          orElse: () => const ViewGroupRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i21.ViewGroupPage(key: args.key));
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: _i22.ProfilePage(key: args.key));
    },
    EditProfileRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.EditProfilePage());
    },
    PreferencesRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i24.PreferencesPage());
    },
    FaqsRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i25.FaqsPage());
    },
    PrivacyRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i26.PrivacyPage());
    },
    LoginRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i27.LoginPage());
    },
    PhoneValidationRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i28.PhoneValidationPage());
    },
    LoadingRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i29.LoadingPage());
    }
  };

  @override
  List<_i30.RouteConfig> get routes => [
        _i30.RouteConfig(RootWrapper.name, path: '/', children: [
          _i30.RouteConfig(OnBoardingWrapper.name,
              path: 'on-boarding-wrapper',
              parent: RootWrapper.name,
              children: [
                _i30.RouteConfig(OnBoardingRoute.name,
                    path: 'on-boarding-page', parent: OnBoardingWrapper.name),
                _i30.RouteConfig(ProgressOnboardingRoute.name,
                    path: 'progress-onboarding-page',
                    parent: OnBoardingWrapper.name)
              ]),
          _i30.RouteConfig(HomeWrapper.name,
              path: 'home-wrapper',
              parent: RootWrapper.name,
              children: [
                _i30.RouteConfig(HomeRoute.name,
                    path: 'home-page',
                    parent: HomeWrapper.name,
                    children: [
                      _i30.RouteConfig(HomeMapRoute.name,
                          path: 'home-map-page', parent: HomeRoute.name),
                      _i30.RouteConfig(ContactsWrapper.name,
                          path: 'contacts-wrapper',
                          parent: HomeRoute.name,
                          children: [
                            _i30.RouteConfig(ContactsRoute.name,
                                path: 'contacts-page',
                                parent: ContactsWrapper.name,
                                children: [
                                  _i30.RouteConfig(FriendsRoute.name,
                                      path: 'friends-page',
                                      parent: ContactsRoute.name),
                                  _i30.RouteConfig(RequestsRoute.name,
                                      path: 'requests-page',
                                      parent: ContactsRoute.name),
                                  _i30.RouteConfig(SuggestionsRoute.name,
                                      path: 'suggestions-page',
                                      parent: ContactsRoute.name)
                                ]),
                            _i30.RouteConfig(SentRequestsRoute.name,
                                path: 'sent-requests-page',
                                parent: ContactsWrapper.name),
                            _i30.RouteConfig(GroupsWrapper.name,
                                path: 'groups-wrapper',
                                parent: ContactsWrapper.name,
                                children: [
                                  _i30.RouteConfig(GroupsRoute.name,
                                      path: 'groups-page',
                                      parent: GroupsWrapper.name),
                                  _i30.RouteConfig(ManageGroupRoute.name,
                                      path: 'manage-group-page',
                                      parent: GroupsWrapper.name),
                                  _i30.RouteConfig(ViewGroupRoute.name,
                                      path: 'view-group-page',
                                      parent: GroupsWrapper.name)
                                ])
                          ]),
                      _i30.RouteConfig(NotificationsRoute.name,
                          path: 'notifications-page', parent: HomeRoute.name),
                      _i30.RouteConfig(ProfileWrapper.name,
                          path: 'profile-wrapper',
                          parent: HomeRoute.name,
                          children: [
                            _i30.RouteConfig(ProfileRoute.name,
                                path: 'profile-page',
                                parent: ProfileWrapper.name),
                            _i30.RouteConfig(EditProfileRoute.name,
                                path: 'edit-profile-page',
                                parent: ProfileWrapper.name),
                            _i30.RouteConfig(PreferencesRoute.name,
                                path: 'preferences-page',
                                parent: ProfileWrapper.name),
                            _i30.RouteConfig(FaqsRoute.name,
                                path: 'faqs-page', parent: ProfileWrapper.name),
                            _i30.RouteConfig(PrivacyRoute.name,
                                path: 'privacy-page',
                                parent: ProfileWrapper.name)
                          ])
                    ]),
                _i30.RouteConfig(ContactProfileRoute.name,
                    path: 'contact-profile-page', parent: HomeWrapper.name)
              ]),
          _i30.RouteConfig(LoginWrapper.name,
              path: 'login-wrapper',
              parent: RootWrapper.name,
              children: [
                _i30.RouteConfig(LoginRoute.name,
                    path: 'login-page', parent: LoginWrapper.name),
                _i30.RouteConfig(PhoneValidationRoute.name,
                    path: 'phone-validation-page', parent: LoginWrapper.name),
                _i30.RouteConfig(LoadingRoute.name,
                    path: 'loading-page', parent: LoginWrapper.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.RootWrapper]
class RootWrapper extends _i30.PageRouteInfo<RootWrapperArgs> {
  RootWrapper({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(RootWrapper.name,
            path: '/',
            args: RootWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'RootWrapper';
}

class RootWrapperArgs {
  const RootWrapperArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'RootWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.OnBoardingWrapper]
class OnBoardingWrapper extends _i30.PageRouteInfo<OnBoardingWrapperArgs> {
  OnBoardingWrapper({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(OnBoardingWrapper.name,
            path: 'on-boarding-wrapper',
            args: OnBoardingWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'OnBoardingWrapper';
}

class OnBoardingWrapperArgs {
  const OnBoardingWrapperArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'OnBoardingWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.HomeWrapper]
class HomeWrapper extends _i30.PageRouteInfo<HomeWrapperArgs> {
  HomeWrapper({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(HomeWrapper.name,
            path: 'home-wrapper',
            args: HomeWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeWrapper';
}

class HomeWrapperArgs {
  const HomeWrapperArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'HomeWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.LoginWrapper]
class LoginWrapper extends _i30.PageRouteInfo<LoginWrapperArgs> {
  LoginWrapper({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(LoginWrapper.name,
            path: 'login-wrapper',
            args: LoginWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'LoginWrapper';
}

class LoginWrapperArgs {
  const LoginWrapperArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'LoginWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.OnBoardingPage]
class OnBoardingRoute extends _i30.PageRouteInfo<OnBoardingRouteArgs> {
  OnBoardingRoute({_i31.Key? key})
      : super(OnBoardingRoute.name,
            path: 'on-boarding-page', args: OnBoardingRouteArgs(key: key));

  static const String name = 'OnBoardingRoute';
}

class OnBoardingRouteArgs {
  const OnBoardingRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'OnBoardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.ProgressOnboardingPage]
class ProgressOnboardingRoute
    extends _i30.PageRouteInfo<ProgressOnboardingRouteArgs> {
  ProgressOnboardingRoute({_i31.Key? key})
      : super(ProgressOnboardingRoute.name,
            path: 'progress-onboarding-page',
            args: ProgressOnboardingRouteArgs(key: key));

  static const String name = 'ProgressOnboardingRoute';
}

class ProgressOnboardingRouteArgs {
  const ProgressOnboardingRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ProgressOnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i30.PageRouteInfo<void> {
  const HomeRoute({List<_i30.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i8.ContactProfilePage]
class ContactProfileRoute extends _i30.PageRouteInfo<ContactProfileRouteArgs> {
  ContactProfileRoute(
      {required _i32.Contact contact,
      required String navigationSource,
      _i33.ContactProfileController? controller,
      _i31.Key? key})
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

  final _i32.Contact contact;

  final String navigationSource;

  final _i33.ContactProfileController? controller;

  final _i31.Key? key;

  @override
  String toString() {
    return 'ContactProfileRouteArgs{contact: $contact, navigationSource: $navigationSource, controller: $controller, key: $key}';
  }
}

/// generated route for
/// [_i9.HomeMapPage]
class HomeMapRoute extends _i30.PageRouteInfo<HomeMapRouteArgs> {
  HomeMapRoute({_i34.MapController? controller, _i31.Key? key})
      : super(HomeMapRoute.name,
            path: 'home-map-page',
            args: HomeMapRouteArgs(controller: controller, key: key));

  static const String name = 'HomeMapRoute';
}

class HomeMapRouteArgs {
  const HomeMapRouteArgs({this.controller, this.key});

  final _i34.MapController? controller;

  final _i31.Key? key;

  @override
  String toString() {
    return 'HomeMapRouteArgs{controller: $controller, key: $key}';
  }
}

/// generated route for
/// [_i10.ContactsWrapper]
class ContactsWrapper extends _i30.PageRouteInfo<ContactsWrapperArgs> {
  ContactsWrapper({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(ContactsWrapper.name,
            path: 'contacts-wrapper',
            args: ContactsWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'ContactsWrapper';
}

class ContactsWrapperArgs {
  const ContactsWrapperArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ContactsWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.NotificationsPage]
class NotificationsRoute extends _i30.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(NotificationsRoute.name, path: 'notifications-page');

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i12.ProfileWrapper]
class ProfileWrapper extends _i30.PageRouteInfo<ProfileWrapperArgs> {
  ProfileWrapper({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(ProfileWrapper.name,
            path: 'profile-wrapper',
            args: ProfileWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'ProfileWrapper';
}

class ProfileWrapperArgs {
  const ProfileWrapperArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ProfileWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.ContactsPage]
class ContactsRoute extends _i30.PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(ContactsRoute.name,
            path: 'contacts-page',
            args: ContactsRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.SentRequestsPage]
class SentRequestsRoute extends _i30.PageRouteInfo<SentRequestsRouteArgs> {
  SentRequestsRoute({_i31.Key? key})
      : super(SentRequestsRoute.name,
            path: 'sent-requests-page', args: SentRequestsRouteArgs(key: key));

  static const String name = 'SentRequestsRoute';
}

class SentRequestsRouteArgs {
  const SentRequestsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'SentRequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.GroupsWrapper]
class GroupsWrapper extends _i30.PageRouteInfo<GroupsWrapperArgs> {
  GroupsWrapper({_i31.Key? key, List<_i30.PageRouteInfo>? children})
      : super(GroupsWrapper.name,
            path: 'groups-wrapper',
            args: GroupsWrapperArgs(key: key),
            initialChildren: children);

  static const String name = 'GroupsWrapper';
}

class GroupsWrapperArgs {
  const GroupsWrapperArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'GroupsWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.FriendsPage]
class FriendsRoute extends _i30.PageRouteInfo<FriendsRouteArgs> {
  FriendsRoute({_i31.Key? key})
      : super(FriendsRoute.name,
            path: 'friends-page', args: FriendsRouteArgs(key: key));

  static const String name = 'FriendsRoute';
}

class FriendsRouteArgs {
  const FriendsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'FriendsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.RequestsPage]
class RequestsRoute extends _i30.PageRouteInfo<RequestsRouteArgs> {
  RequestsRoute({_i31.Key? key})
      : super(RequestsRoute.name,
            path: 'requests-page', args: RequestsRouteArgs(key: key));

  static const String name = 'RequestsRoute';
}

class RequestsRouteArgs {
  const RequestsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'RequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.SuggestionsPage]
class SuggestionsRoute extends _i30.PageRouteInfo<SuggestionsRouteArgs> {
  SuggestionsRoute({_i31.Key? key})
      : super(SuggestionsRoute.name,
            path: 'suggestions-page', args: SuggestionsRouteArgs(key: key));

  static const String name = 'SuggestionsRoute';
}

class SuggestionsRouteArgs {
  const SuggestionsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'SuggestionsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.GroupsPage]
class GroupsRoute extends _i30.PageRouteInfo<GroupsRouteArgs> {
  GroupsRoute({_i31.Key? key})
      : super(GroupsRoute.name,
            path: 'groups-page', args: GroupsRouteArgs(key: key));

  static const String name = 'GroupsRoute';
}

class GroupsRouteArgs {
  const GroupsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'GroupsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.ManageGroupPage]
class ManageGroupRoute extends _i30.PageRouteInfo<ManageGroupRouteArgs> {
  ManageGroupRoute(
      {_i35.ManageGroupController? controller,
      _i36.Group? group,
      _i31.Key? key})
      : super(ManageGroupRoute.name,
            path: 'manage-group-page',
            args: ManageGroupRouteArgs(
                controller: controller, group: group, key: key));

  static const String name = 'ManageGroupRoute';
}

class ManageGroupRouteArgs {
  const ManageGroupRouteArgs({this.controller, this.group, this.key});

  final _i35.ManageGroupController? controller;

  final _i36.Group? group;

  final _i31.Key? key;

  @override
  String toString() {
    return 'ManageGroupRouteArgs{controller: $controller, group: $group, key: $key}';
  }
}

/// generated route for
/// [_i21.ViewGroupPage]
class ViewGroupRoute extends _i30.PageRouteInfo<ViewGroupRouteArgs> {
  ViewGroupRoute({_i31.Key? key})
      : super(ViewGroupRoute.name,
            path: 'view-group-page', args: ViewGroupRouteArgs(key: key));

  static const String name = 'ViewGroupRoute';
}

class ViewGroupRouteArgs {
  const ViewGroupRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ViewGroupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i22.ProfilePage]
class ProfileRoute extends _i30.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i31.Key? key})
      : super(ProfileRoute.name,
            path: 'profile-page', args: ProfileRouteArgs(key: key));

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i23.EditProfilePage]
class EditProfileRoute extends _i30.PageRouteInfo<void> {
  const EditProfileRoute()
      : super(EditProfileRoute.name, path: 'edit-profile-page');

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [_i24.PreferencesPage]
class PreferencesRoute extends _i30.PageRouteInfo<void> {
  const PreferencesRoute()
      : super(PreferencesRoute.name, path: 'preferences-page');

  static const String name = 'PreferencesRoute';
}

/// generated route for
/// [_i25.FaqsPage]
class FaqsRoute extends _i30.PageRouteInfo<void> {
  const FaqsRoute() : super(FaqsRoute.name, path: 'faqs-page');

  static const String name = 'FaqsRoute';
}

/// generated route for
/// [_i26.PrivacyPage]
class PrivacyRoute extends _i30.PageRouteInfo<void> {
  const PrivacyRoute() : super(PrivacyRoute.name, path: 'privacy-page');

  static const String name = 'PrivacyRoute';
}

/// generated route for
/// [_i27.LoginPage]
class LoginRoute extends _i30.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i28.PhoneValidationPage]
class PhoneValidationRoute extends _i30.PageRouteInfo<void> {
  const PhoneValidationRoute()
      : super(PhoneValidationRoute.name, path: 'phone-validation-page');

  static const String name = 'PhoneValidationRoute';
}

/// generated route for
/// [_i29.LoadingPage]
class LoadingRoute extends _i30.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: 'loading-page');

  static const String name = 'LoadingRoute';
}
