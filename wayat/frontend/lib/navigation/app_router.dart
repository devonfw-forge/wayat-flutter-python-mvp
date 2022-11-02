import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/features/authentication/page/phone_verification_missing_page.dart';
import 'package:wayat/features/contact_profile/page/contact_profile_page.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/features/contacts/pages/sent_requests_page/sent_requests_page.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/pages/groups_page.dart';
import 'package:wayat/features/groups/pages/manage_group_page.dart';
import 'package:wayat/features/groups/pages/view_group_page.dart';
import 'package:wayat/features/home/pages/home_page.dart';
import 'package:wayat/features/home/pages/home_tabs.dart';
import 'package:wayat/features/map/page/map_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';
import 'package:wayat/features/profile/pages/edit_profile_page/edit_profile_page.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/navigation/initial_route.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

class AppRouter {
  final ValueKey<String> _scaffoldKey =
      const ValueKey<String>('wayat_scaffold');
  final ValueKey<String> _profileScaffoldKey =
      const ValueKey<String>('contact_profile_scaffold');
  UserState userState = GetIt.I.get<UserState>();
  PlatformService platformService = PlatformService();
  InitialLocationProvider initialLocationProvider =
      GetIt.I.get<InitialLocationProvider>();

  late final GoRouter router = GoRouter(
    initialLocation: initialLocationProvider.initialLocation.value,
    navigatorKey: GetIt.I.get<GlobalKey<NavigatorState>>(),
    errorBuilder: (context, state) => ErrorPage(url: state.location),
    debugLogDiagnostics: true,
    redirect: authenticationGuard,
    routes: [
      // Makes map the default page if you enter just the domain name
      GoRoute(path: '/', redirect: (_, __) => '/map'),
      GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          }),
      // Main screen navigation
      GoRoute(
          path: '/map',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
              key: _scaffoldKey,
              child: HomePage(
                selectedSection: HomeTab.map,
                child: MapPage(),
              ),
            );
          },
          routes: [
            GoRoute(
              path: 'contact/:id',
              redirect: (context, state) async =>
                  await contactProfileGuard(state),
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                    key: _profileScaffoldKey,
                    child: ContactProfilePage(
                        contact: GetIt.I.get<HomeNavState>().selectedContact!,
                        navigationSource: "/map"));
              },
            ),
          ]),
      GoRoute(path: '/contacts', redirect: (_, __) => '/contacts/friends'),
      GoRoute(
          path: '/contact/:id',
          redirect: (_, state) => '/contacts/friends/${state.params['id']}'),
      GoRoute(
          path: '/contacts/:kind(friends|requests|suggestions)',
          redirect: (context, state) {
            if (PlatformService().isDesktopOrWeb &&
                state.location == '/contacts/suggestions') {
              return '/contacts/friends';
            }
            return null;
          },
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                key: _scaffoldKey,
                child: HomePage(
                  selectedSection: HomeTab.contacts,
                  child: ContactsPage(state.params['kind'] ?? "friends"),
                ));
          },
          routes: [
            GoRoute(
              redirect: sentRequestsGuard,
              path: 'sent-requests',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: HomePage(
                  selectedSection: HomeTab.contacts,
                  child: SentRequestsPage(),
                ));
              },
            ),
            GoRoute(
                path: 'groups',
                redirect: (context, state) =>
                    (state.location == '/contacts/requests/groups' ||
                            state.location == '/contacts/suggestions/groups')
                        ? '/contacts/friends/groups'
                        : null,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                      child: HomePage(
                    selectedSection: HomeTab.contacts,
                    child: GroupsPage(),
                  ));
                },
                routes: [
                  GoRoute(
                      path: 'create',
                      pageBuilder: (context, state) => NoTransitionPage(
                            child: HomePage(
                              selectedSection: HomeTab.contacts,
                              child: ManageGroupPage(),
                            ),
                          )),
                  GoRoute(
                      path: ':id',
                      redirect: (context, state) async =>
                          await groupsGuard(state),
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                            child: HomePage(
                          selectedSection: HomeTab.contacts,
                          child: ViewGroupPage(),
                        ));
                      },
                      routes: [
                        GoRoute(
                            path: 'edit',
                            redirect: (context, state) async =>
                                await groupsGuard(state),
                            pageBuilder: (context, state) => NoTransitionPage(
                                  child: HomePage(
                                    selectedSection: HomeTab.contacts,
                                    child: ManageGroupPage(
                                      group: GetIt.I
                                          .get<GroupsController>()
                                          .selectedGroup,
                                    ),
                                  ),
                                )),
                      ])
                ]),
            GoRoute(
              path: ':id',
              redirect: (context, state) async =>
                  await contactProfileGuard(state),
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                    key: _profileScaffoldKey,
                    child: ContactProfilePage(
                        contact: GetIt.I.get<HomeNavState>().selectedContact!,
                        navigationSource: "/contacts/friends"));
              },
            ),
          ]),
      GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => FadeTransitionPage(
                key: _scaffoldKey,
                child: HomePage(
                  selectedSection: HomeTab.profile,
                  child: ProfilePage(),
                ),
              ),
          routes: [
            GoRoute(
              path: "edit",
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: HomePage(
                    selectedSection: HomeTab.profile,
                    child: EditProfilePage(),
                  ),
                );
              },
            ),
            GoRoute(
              path: "preferences",
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: HomePage(
                    selectedSection: HomeTab.profile,
                    child: PreferencesPage(),
                  ),
                );
              },
            )
          ]),
      GoRoute(
          path: '/phone-verification',
          builder: (BuildContext context, GoRouterState state) {
            return PhoneValidationPage();
          }),
      GoRoute(
          redirect: onboardingGuard,
          path: '/onboarding',
          builder: (BuildContext context, GoRouterState state) {
            return OnBoardingPage();
          },
          routes: [
            GoRoute(
                path: 'progress',
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: ProgressOnboardingPage()))
          ]),
      GoRoute(
          path: '/phone-verification-missing',
          builder: (BuildContext context, GoRouterState state) {
            return PhoneVerificationMissingPage();
          }),
    ],
  );

  FutureOr<String?> sentRequestsGuard(context, state) async {
    if (state.location == '/contacts/friends/sent-requests' ||
        state.location == '/contacts/suggestions/sent-requests') {
      return '/contacts/requests/sent-requests';
    }

    RequestsController requestsController =
        GetIt.I.get<ContactsPageController>().requestsController;
    if (requestsController.sentRequests.isEmpty) {
      await requestsController.updateRequests();
    }
    return null;
  }

  FutureOr<String?> onboardingGuard(context, state) =>
      (platformService.isWeb) ? '/' : null;

  Future<String?> contactProfileGuard(GoRouterState state) async {
    if (state.location.startsWith("/contacts/suggestions") ||
        state.location.startsWith("/contacts/requests")) {
      return "/not-found";
    }
    HomeNavState homeNavState = GetIt.I.get<HomeNavState>();
    await homeNavState.contactProfileGuard(state.params['id']!);
    if (homeNavState.selectedContact == null) {
      return '/not-found';
    }
    return null;
  }

  Future<String?> groupsGuard(GoRouterState state) async {
    GroupsController groupsController = GetIt.I.get<GroupsController>();
    await groupsController.groupsGuard(state.params['id']!);
    if (groupsController.selectedGroup == null) {
      return '/not-found';
    }
    return null;
  }

  FutureOr<String?> authenticationGuard(context, state) async {
    if (await userState.isLogged()) {
      if (userState.currentUser == null) {
        await userState.initializeCurrentUser();
      }
      if (userState.currentUser!.phone.isEmpty) {
        if (platformService.isDesktopOrWeb) {
          if (state.location == '/phone-verification-missing') {
            return null;
          }
          return '/phone-verification-missing';
        } else {
          if (state.location == '/phone-verification') {
            return null;
          }
          return '/phone-verification';
        }
      }
      if (userState.currentUser!.onboardingCompleted == false &&
          !platformService.isDesktopOrWeb &&
          (state.location != '/onboarding' &&
              state.location != '/onboarding/progress')) {
        return '/onboarding';
      }
      //if (initialLocationProvider.shouldRedirect(state)) {
      //return initialLocationProvider.initialLocation.value;
      //}
      if (state.location == '/') {
        return '/map';
      }
    } else {
      if (state.location != '/login') {
        return '/login';
      }
    }
    return null;
  }
}

class ErrorPage extends StatelessWidget {
  final String url;
  const ErrorPage({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> errors = (url == "/server-error")
        ? {"errorCode": "500", "errorMessage": appLocalizations.errorServer}
        : {"errorCode": "404", "errorMessage": appLocalizations.errorNotFound};

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(40), child: CustomAppBar()),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              errors["errorCode"]!,
              style: const TextStyle(
                  color: ColorTheme.primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              errors["errorMessage"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextIconButton(
              text: appLocalizations.returnToWayat,
              icon: Icons.arrow_back_sharp,
              onPressed: () => context.go("/map"),
              fontSize: 18,
            )
          ],
        ),
      ),
    );
  }
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
