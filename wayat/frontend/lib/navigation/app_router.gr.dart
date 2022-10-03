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
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:flutter/material.dart' as _i28;

import '../domain/contact/contact.dart' as _i29;
import '../domain/group/group.dart' as _i33;
import '../features/authentication/page/loading_page.dart' as _i21;
import '../features/authentication/page/login_page.dart' as _i25;
import '../features/authentication/page/login_wrapper.dart' as _i4;
import '../features/authentication/page/phone_validation_page.dart' as _i26;
import '../features/contact_profile/controller/contact_profile_controller.dart'
    as _i30;
import '../features/contact_profile/page/contact_profile_page.dart' as _i8;
import '../features/contacts/pages/contacts_page/contacts_page.dart' as _i12;
import '../features/contacts/pages/contacts_page/friends_page/friends_page.dart'
    as _i15;
import '../features/contacts/pages/contacts_page/requests_page/requests_page.dart'
    as _i16;
import '../features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart'
    as _i17;
import '../features/contacts/pages/contacts_wrapper.dart' as _i10;
import '../features/contacts/pages/sent_requests_page/sent_requests_page.dart'
    as _i13;
import '../features/groups/controllers/manage_group_controller/manage_group_controller.dart'
    as _i32;
import '../features/groups/pages/groups_page.dart' as _i18;
import '../features/groups/pages/groups_wrapper.dart' as _i14;
import '../features/groups/pages/manage_group_page.dart' as _i19;
import '../features/groups/pages/view_group_page.dart' as _i20;
import '../features/home/pages/home_page.dart' as _i7;
import '../features/home/pages/home_wrapper.dart' as _i3;
import '../features/map/controller/map_controller.dart' as _i31;
import '../features/map/page/home_map_page.dart' as _i9;
import '../features/onboarding/pages/onboarding_page.dart' as _i5;
import '../features/onboarding/pages/onboarding_wrapper.dart' as _i2;
import '../features/onboarding/pages/progress_page.dart' as _i6;
import '../features/profile/controllers/edit_profile_controller.dart' as _i34;
import '../features/profile/controllers/phone_verification_controller.dart'
    as _i35;
import '../features/profile/pages/edit_profile_page/edit_profile_page.dart'
    as _i23;
import '../features/profile/pages/preferences_page/preferences_page.dart'
    as _i24;
import '../features/profile/pages/profile_page.dart' as _i22;
import '../features/profile/pages/profile_wraper.dart' as _i11;
import '../features/root/root_wrapper.dart' as _i1;

class AppRouter extends _i27.RootStackRouter {
  AppRouter([_i28.GlobalKey<_i28.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i27.PageFactory> pagesMap = {
    RootWrapper.name: (routeData) {
      final args = routeData.argsAs<RootWrapperArgs>(
          orElse: () => const RootWrapperArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.RootWrapper(key: args.key),
      );
    },
    OnBoardingWrapper.name: (routeData) {
      final args = routeData.argsAs<OnBoardingWrapperArgs>(
          orElse: () => const OnBoardingWrapperArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.OnBoardingWrapper(key: args.key),
      );
    },
    HomeWrapper.name: (routeData) {
      final args = routeData.argsAs<HomeWrapperArgs>(
          orElse: () => const HomeWrapperArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.HomeWrapper(key: args.key),
      );
    },
    LoginWrapper.name: (routeData) {
      final args = routeData.argsAs<LoginWrapperArgs>(
          orElse: () => const LoginWrapperArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.LoginWrapper(key: args.key),
      );
    },
    OnBoardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingRouteArgs>(
          orElse: () => const OnBoardingRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.OnBoardingPage(key: args.key),
      );
    },
    ProgressOnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressOnboardingRouteArgs>(
          orElse: () => const ProgressOnboardingRouteArgs());
      return _i27.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.ProgressOnboardingPage(key: args.key),
        transitionsBuilder: _i27.TransitionsBuilders.slideLeft,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.HomePage(),
      );
    },
    ContactProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ContactProfileRouteArgs>();
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.ContactProfilePage(
          contact: args.contact,
          navigationSource: args.navigationSource,
          controller: args.controller,
          key: args.key,
        ),
      );
    },
    HomeMapRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMapRouteArgs>(
          orElse: () => const HomeMapRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.HomeMapPage(
          controller: args.controller,
          key: args.key,
        ),
      );
    },
    ContactsWrapper.name: (routeData) {
      final args = routeData.argsAs<ContactsWrapperArgs>(
          orElse: () => const ContactsWrapperArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ContactsWrapper(key: args.key),
      );
    },
    ProfileWrapper.name: (routeData) {
      final args = routeData.argsAs<ProfileWrapperArgs>(
          orElse: () => const ProfileWrapperArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.ProfileWrapper(key: args.key),
      );
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.ContactsPage(key: args.key),
      );
    },
    SentRequestsRoute.name: (routeData) {
      final args = routeData.argsAs<SentRequestsRouteArgs>(
          orElse: () => const SentRequestsRouteArgs());
      return _i27.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.SentRequestsPage(key: args.key),
        transitionsBuilder: _i27.TransitionsBuilders.slideLeftWithFade,
        opaque: true,
        barrierDismissible: false,
      );
    },
    GroupsWrapper.name: (routeData) {
      final args = routeData.argsAs<GroupsWrapperArgs>(
          orElse: () => const GroupsWrapperArgs());
      return _i27.CustomPage<dynamic>(
        routeData: routeData,
        child: _i14.GroupsWrapper(key: args.key),
        transitionsBuilder: _i27.TransitionsBuilders.slideLeftWithFade,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FriendsRoute.name: (routeData) {
      final args = routeData.argsAs<FriendsRouteArgs>(
          orElse: () => const FriendsRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.FriendsPage(key: args.key),
      );
    },
    RequestsRoute.name: (routeData) {
      final args = routeData.argsAs<RequestsRouteArgs>(
          orElse: () => const RequestsRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.RequestsPage(key: args.key),
      );
    },
    SuggestionsRoute.name: (routeData) {
      final args = routeData.argsAs<SuggestionsRouteArgs>(
          orElse: () => const SuggestionsRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.SuggestionsPage(key: args.key),
      );
    },
    GroupsRoute.name: (routeData) {
      final args = routeData.argsAs<GroupsRouteArgs>(
          orElse: () => const GroupsRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.GroupsPage(key: args.key),
      );
    },
    ManageGroupRoute.name: (routeData) {
      final args = routeData.argsAs<ManageGroupRouteArgs>(
          orElse: () => const ManageGroupRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.ManageGroupPage(
          controller: args.controller,
          group: args.group,
          key: args.key,
        ),
      );
    },
    ViewGroupRoute.name: (routeData) {
      final args = routeData.argsAs<ViewGroupRouteArgs>(
          orElse: () => const ViewGroupRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.ViewGroupPage(key: args.key),
      );
    },
    LoadingGroupRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.LoadingPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i22.ProfilePage(key: args.key),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () => const EditProfileRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i23.EditProfilePage(
          key: args.key,
          controller: args.controller,
          phoneController: args.phoneController,
        ),
      );
    },
    PreferencesRoute.name: (routeData) {
      final args = routeData.argsAs<PreferencesRouteArgs>(
          orElse: () => const PreferencesRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i24.PreferencesPage(
          key: args.key,
          controller: args.controller,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.LoginPage(),
      );
    },
    PhoneValidationRoute.name: (routeData) {
      final args = routeData.argsAs<PhoneValidationRouteArgs>(
          orElse: () => const PhoneValidationRouteArgs());
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i26.PhoneValidationPage(
          key: args.key,
          phoneController: args.phoneController,
        ),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.LoadingPage(),
      );
    },
  };

  @override
  List<_i27.RouteConfig> get routes => [
        _i27.RouteConfig(
          RootWrapper.name,
          path: '/',
          children: [
            _i27.RouteConfig(
              OnBoardingWrapper.name,
              path: 'on-boarding-wrapper',
              parent: RootWrapper.name,
              children: [
                _i27.RouteConfig(
                  OnBoardingRoute.name,
                  path: 'on-boarding-page',
                  parent: OnBoardingWrapper.name,
                ),
                _i27.RouteConfig(
                  ProgressOnboardingRoute.name,
                  path: 'progress-onboarding-page',
                  parent: OnBoardingWrapper.name,
                ),
              ],
            ),
            _i27.RouteConfig(
              HomeWrapper.name,
              path: 'home-wrapper',
              parent: RootWrapper.name,
              children: [
                _i27.RouteConfig(
                  HomeRoute.name,
                  path: 'home-page',
                  parent: HomeWrapper.name,
                  children: [
                    _i27.RouteConfig(
                      HomeMapRoute.name,
                      path: 'home-map-page',
                      parent: HomeRoute.name,
                    ),
                    _i27.RouteConfig(
                      ContactsWrapper.name,
                      path: 'contacts-wrapper',
                      parent: HomeRoute.name,
                      children: [
                        _i27.RouteConfig(
                          ContactsRoute.name,
                          path: 'contacts-page',
                          parent: ContactsWrapper.name,
                          children: [
                            _i27.RouteConfig(
                              FriendsRoute.name,
                              path: 'friends-page',
                              parent: ContactsRoute.name,
                            ),
                            _i27.RouteConfig(
                              RequestsRoute.name,
                              path: 'requests-page',
                              parent: ContactsRoute.name,
                            ),
                            _i27.RouteConfig(
                              SuggestionsRoute.name,
                              path: 'suggestions-page',
                              parent: ContactsRoute.name,
                            ),
                          ],
                        ),
                        _i27.RouteConfig(
                          SentRequestsRoute.name,
                          path: 'sent-requests-page',
                          parent: ContactsWrapper.name,
                        ),
                        _i27.RouteConfig(
                          GroupsWrapper.name,
                          path: 'groups-wrapper',
                          parent: ContactsWrapper.name,
                          children: [
                            _i27.RouteConfig(
                              GroupsRoute.name,
                              path: 'groups-page',
                              parent: GroupsWrapper.name,
                            ),
                            _i27.RouteConfig(
                              ManageGroupRoute.name,
                              path: 'manage-group-page',
                              parent: GroupsWrapper.name,
                            ),
                            _i27.RouteConfig(
                              ViewGroupRoute.name,
                              path: 'view-group-page',
                              parent: GroupsWrapper.name,
                            ),
                            _i27.RouteConfig(
                              LoadingGroupRoute.name,
                              path: 'loading-page',
                              parent: GroupsWrapper.name,
                            ),
                          ],
                        ),
                      ],
                    ),
                    _i27.RouteConfig(
                      ProfileWrapper.name,
                      path: 'profile-wrapper',
                      parent: HomeRoute.name,
                      children: [
                        _i27.RouteConfig(
                          ProfileRoute.name,
                          path: 'profile-page',
                          parent: ProfileWrapper.name,
                        ),
                        _i27.RouteConfig(
                          EditProfileRoute.name,
                          path: 'edit-profile-page',
                          parent: ProfileWrapper.name,
                        ),
                        _i27.RouteConfig(
                          PreferencesRoute.name,
                          path: 'preferences-page',
                          parent: ProfileWrapper.name,
                        ),
                      ],
                    ),
                  ],
                ),
                _i27.RouteConfig(
                  ContactProfileRoute.name,
                  path: 'contact-profile-page',
                  parent: HomeWrapper.name,
                ),
              ],
            ),
            _i27.RouteConfig(
              LoginWrapper.name,
              path: 'login-wrapper',
              parent: RootWrapper.name,
              children: [
                _i27.RouteConfig(
                  LoginRoute.name,
                  path: 'login-page',
                  parent: LoginWrapper.name,
                ),
                _i27.RouteConfig(
                  PhoneValidationRoute.name,
                  path: 'phone-validation-page',
                  parent: LoginWrapper.name,
                ),
                _i27.RouteConfig(
                  LoadingRoute.name,
                  path: 'loading-page',
                  parent: LoginWrapper.name,
                ),
              ],
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.RootWrapper]
class RootWrapper extends _i27.PageRouteInfo<RootWrapperArgs> {
  RootWrapper({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          RootWrapper.name,
          path: '/',
          args: RootWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RootWrapper';
}

class RootWrapperArgs {
  const RootWrapperArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'RootWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.OnBoardingWrapper]
class OnBoardingWrapper extends _i27.PageRouteInfo<OnBoardingWrapperArgs> {
  OnBoardingWrapper({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          OnBoardingWrapper.name,
          path: 'on-boarding-wrapper',
          args: OnBoardingWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoardingWrapper';
}

class OnBoardingWrapperArgs {
  const OnBoardingWrapperArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'OnBoardingWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.HomeWrapper]
class HomeWrapper extends _i27.PageRouteInfo<HomeWrapperArgs> {
  HomeWrapper({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          HomeWrapper.name,
          path: 'home-wrapper',
          args: HomeWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeWrapper';
}

class HomeWrapperArgs {
  const HomeWrapperArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'HomeWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.LoginWrapper]
class LoginWrapper extends _i27.PageRouteInfo<LoginWrapperArgs> {
  LoginWrapper({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          LoginWrapper.name,
          path: 'login-wrapper',
          args: LoginWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginWrapper';
}

class LoginWrapperArgs {
  const LoginWrapperArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'LoginWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.OnBoardingPage]
class OnBoardingRoute extends _i27.PageRouteInfo<OnBoardingRouteArgs> {
  OnBoardingRoute({_i28.Key? key})
      : super(
          OnBoardingRoute.name,
          path: 'on-boarding-page',
          args: OnBoardingRouteArgs(key: key),
        );

  static const String name = 'OnBoardingRoute';
}

class OnBoardingRouteArgs {
  const OnBoardingRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'OnBoardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.ProgressOnboardingPage]
class ProgressOnboardingRoute
    extends _i27.PageRouteInfo<ProgressOnboardingRouteArgs> {
  ProgressOnboardingRoute({_i28.Key? key})
      : super(
          ProgressOnboardingRoute.name,
          path: 'progress-onboarding-page',
          args: ProgressOnboardingRouteArgs(key: key),
        );

  static const String name = 'ProgressOnboardingRoute';
}

class ProgressOnboardingRouteArgs {
  const ProgressOnboardingRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'ProgressOnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i27.PageRouteInfo<void> {
  const HomeRoute({List<_i27.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home-page',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i8.ContactProfilePage]
class ContactProfileRoute extends _i27.PageRouteInfo<ContactProfileRouteArgs> {
  ContactProfileRoute({
    required _i29.Contact contact,
    required String navigationSource,
    _i30.ContactProfileController? controller,
    _i28.Key? key,
  }) : super(
          ContactProfileRoute.name,
          path: 'contact-profile-page',
          args: ContactProfileRouteArgs(
            contact: contact,
            navigationSource: navigationSource,
            controller: controller,
            key: key,
          ),
        );

  static const String name = 'ContactProfileRoute';
}

class ContactProfileRouteArgs {
  const ContactProfileRouteArgs({
    required this.contact,
    required this.navigationSource,
    this.controller,
    this.key,
  });

  final _i29.Contact contact;

  final String navigationSource;

  final _i30.ContactProfileController? controller;

  final _i28.Key? key;

  @override
  String toString() {
    return 'ContactProfileRouteArgs{contact: $contact, navigationSource: $navigationSource, controller: $controller, key: $key}';
  }
}

/// generated route for
/// [_i9.HomeMapPage]
class HomeMapRoute extends _i27.PageRouteInfo<HomeMapRouteArgs> {
  HomeMapRoute({
    _i31.MapController? controller,
    _i28.Key? key,
  }) : super(
          HomeMapRoute.name,
          path: 'home-map-page',
          args: HomeMapRouteArgs(
            controller: controller,
            key: key,
          ),
        );

  static const String name = 'HomeMapRoute';
}

class HomeMapRouteArgs {
  const HomeMapRouteArgs({
    this.controller,
    this.key,
  });

  final _i31.MapController? controller;

  final _i28.Key? key;

  @override
  String toString() {
    return 'HomeMapRouteArgs{controller: $controller, key: $key}';
  }
}

/// generated route for
/// [_i10.ContactsWrapper]
class ContactsWrapper extends _i27.PageRouteInfo<ContactsWrapperArgs> {
  ContactsWrapper({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          ContactsWrapper.name,
          path: 'contacts-wrapper',
          args: ContactsWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ContactsWrapper';
}

class ContactsWrapperArgs {
  const ContactsWrapperArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'ContactsWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.ProfileWrapper]
class ProfileWrapper extends _i27.PageRouteInfo<ProfileWrapperArgs> {
  ProfileWrapper({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          ProfileWrapper.name,
          path: 'profile-wrapper',
          args: ProfileWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileWrapper';
}

class ProfileWrapperArgs {
  const ProfileWrapperArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'ProfileWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.ContactsPage]
class ContactsRoute extends _i27.PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          ContactsRoute.name,
          path: 'contacts-page',
          args: ContactsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.SentRequestsPage]
class SentRequestsRoute extends _i27.PageRouteInfo<SentRequestsRouteArgs> {
  SentRequestsRoute({_i28.Key? key})
      : super(
          SentRequestsRoute.name,
          path: 'sent-requests-page',
          args: SentRequestsRouteArgs(key: key),
        );

  static const String name = 'SentRequestsRoute';
}

class SentRequestsRouteArgs {
  const SentRequestsRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'SentRequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.GroupsWrapper]
class GroupsWrapper extends _i27.PageRouteInfo<GroupsWrapperArgs> {
  GroupsWrapper({
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          GroupsWrapper.name,
          path: 'groups-wrapper',
          args: GroupsWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'GroupsWrapper';
}

class GroupsWrapperArgs {
  const GroupsWrapperArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'GroupsWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.FriendsPage]
class FriendsRoute extends _i27.PageRouteInfo<FriendsRouteArgs> {
  FriendsRoute({_i28.Key? key})
      : super(
          FriendsRoute.name,
          path: 'friends-page',
          args: FriendsRouteArgs(key: key),
        );

  static const String name = 'FriendsRoute';
}

class FriendsRouteArgs {
  const FriendsRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'FriendsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.RequestsPage]
class RequestsRoute extends _i27.PageRouteInfo<RequestsRouteArgs> {
  RequestsRoute({_i28.Key? key})
      : super(
          RequestsRoute.name,
          path: 'requests-page',
          args: RequestsRouteArgs(key: key),
        );

  static const String name = 'RequestsRoute';
}

class RequestsRouteArgs {
  const RequestsRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'RequestsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.SuggestionsPage]
class SuggestionsRoute extends _i27.PageRouteInfo<SuggestionsRouteArgs> {
  SuggestionsRoute({_i28.Key? key})
      : super(
          SuggestionsRoute.name,
          path: 'suggestions-page',
          args: SuggestionsRouteArgs(key: key),
        );

  static const String name = 'SuggestionsRoute';
}

class SuggestionsRouteArgs {
  const SuggestionsRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'SuggestionsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.GroupsPage]
class GroupsRoute extends _i27.PageRouteInfo<GroupsRouteArgs> {
  GroupsRoute({_i28.Key? key})
      : super(
          GroupsRoute.name,
          path: 'groups-page',
          args: GroupsRouteArgs(key: key),
        );

  static const String name = 'GroupsRoute';
}

class GroupsRouteArgs {
  const GroupsRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'GroupsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.ManageGroupPage]
class ManageGroupRoute extends _i27.PageRouteInfo<ManageGroupRouteArgs> {
  ManageGroupRoute({
    _i32.ManageGroupController? controller,
    _i33.Group? group,
    _i28.Key? key,
  }) : super(
          ManageGroupRoute.name,
          path: 'manage-group-page',
          args: ManageGroupRouteArgs(
            controller: controller,
            group: group,
            key: key,
          ),
        );

  static const String name = 'ManageGroupRoute';
}

class ManageGroupRouteArgs {
  const ManageGroupRouteArgs({
    this.controller,
    this.group,
    this.key,
  });

  final _i32.ManageGroupController? controller;

  final _i33.Group? group;

  final _i28.Key? key;

  @override
  String toString() {
    return 'ManageGroupRouteArgs{controller: $controller, group: $group, key: $key}';
  }
}

/// generated route for
/// [_i20.ViewGroupPage]
class ViewGroupRoute extends _i27.PageRouteInfo<ViewGroupRouteArgs> {
  ViewGroupRoute({_i28.Key? key})
      : super(
          ViewGroupRoute.name,
          path: 'view-group-page',
          args: ViewGroupRouteArgs(key: key),
        );

  static const String name = 'ViewGroupRoute';
}

class ViewGroupRouteArgs {
  const ViewGroupRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'ViewGroupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.LoadingPage]
class LoadingGroupRoute extends _i27.PageRouteInfo<void> {
  const LoadingGroupRoute()
      : super(
          LoadingGroupRoute.name,
          path: 'loading-page',
        );

  static const String name = 'LoadingGroupRoute';
}

/// generated route for
/// [_i22.ProfilePage]
class ProfileRoute extends _i27.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i28.Key? key})
      : super(
          ProfileRoute.name,
          path: 'profile-page',
          args: ProfileRouteArgs(key: key),
        );

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i23.EditProfilePage]
class EditProfileRoute extends _i27.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i28.Key? key,
    _i34.EditProfileController? controller,
    _i35.PhoneVerificationController? phoneController,
  }) : super(
          EditProfileRoute.name,
          path: 'edit-profile-page',
          args: EditProfileRouteArgs(
            key: key,
            controller: controller,
            phoneController: phoneController,
          ),
        );

  static const String name = 'EditProfileRoute';
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    this.controller,
    this.phoneController,
  });

  final _i28.Key? key;

  final _i34.EditProfileController? controller;

  final _i35.PhoneVerificationController? phoneController;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, controller: $controller, phoneController: $phoneController}';
  }
}

/// generated route for
/// [_i24.PreferencesPage]
class PreferencesRoute extends _i27.PageRouteInfo<PreferencesRouteArgs> {
  PreferencesRoute({
    _i28.Key? key,
    dynamic controller,
  }) : super(
          PreferencesRoute.name,
          path: 'preferences-page',
          args: PreferencesRouteArgs(
            key: key,
            controller: controller,
          ),
        );

  static const String name = 'PreferencesRoute';
}

class PreferencesRouteArgs {
  const PreferencesRouteArgs({
    this.key,
    this.controller,
  });

  final _i28.Key? key;

  final dynamic controller;

  @override
  String toString() {
    return 'PreferencesRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i25.LoginPage]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i26.PhoneValidationPage]
class PhoneValidationRoute
    extends _i27.PageRouteInfo<PhoneValidationRouteArgs> {
  PhoneValidationRoute({
    _i28.Key? key,
    _i35.PhoneVerificationController? phoneController,
  }) : super(
          PhoneValidationRoute.name,
          path: 'phone-validation-page',
          args: PhoneValidationRouteArgs(
            key: key,
            phoneController: phoneController,
          ),
        );

  static const String name = 'PhoneValidationRoute';
}

class PhoneValidationRouteArgs {
  const PhoneValidationRouteArgs({
    this.key,
    this.phoneController,
  });

  final _i28.Key? key;

  final _i35.PhoneVerificationController? phoneController;

  @override
  String toString() {
    return 'PhoneValidationRouteArgs{key: $key, phoneController: $phoneController}';
  }
}

/// generated route for
/// [_i21.LoadingPage]
class LoadingRoute extends _i27.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: 'loading-page',
        );

  static const String name = 'LoadingRoute';
}
