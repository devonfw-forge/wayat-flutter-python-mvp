import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/custom_card.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:mockito/annotations.dart';

import '../../../test_common/test_app.dart';
import 'profile_test.mocks.dart';

@GenerateMocks([UserState, ShareLocationState, LocationListener])
void main() async {
  final MockUserState mockUserState = MockUserState();
  final MockShareLocationState mockLocationState = MockShareLocationState();
  final MockLocationListener mockLocationListener = MockLocationListener();
  late MyUser user;

  setUpAll(() {
    HttpOverrides.global = null;
    user = MyUser(
        id: "2",
        name: "test",
        email: "test@capg.com",
        imageUrl: "http://example.com",
        phonePrefix: "+34",
        phone: "123456789",
        onboardingCompleted: true,
        shareLocationEnabled: true);
    GetIt.I.registerSingleton<UserState>(mockUserState);
    when(mockUserState.currentUser).thenAnswer((_) => user);

    GetIt.I.registerSingleton<LocationListener>(mockLocationListener);
    GetIt.I.registerSingleton<ShareLocationState>(mockLocationState);
    when(mockLocationState.shareLocationEnabled).thenReturn(false);
    when(mockLocationListener.shareLocationState).thenReturn(mockLocationState);
  });

  testWidgets('Profile page has Profile label', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ProfilePage()));
    expect(find.text(appLocalizations.profile), findsOneWidget);
  });

  group("Profile page has user profile data", () {
    testWidgets('Profile image', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: ProfilePage()));
      expect(find.byKey(const Key("profile_image")), findsOneWidget);
    });

    testWidgets('Username', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: ProfilePage()));
      expect(find.text(user.name), findsOneWidget);
    });
  });

  group("Share location settings UI", () {
    testWidgets('Settings title', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: ProfilePage()));
      expect(find.text(appLocalizations.profileShareLocation), findsOneWidget);
    });

    testWidgets('Switch active location', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: ProfilePage()));
      expect(find.text(appLocalizations.profileActiveLocation), findsOneWidget);
      expect(find.byType(CustomSwitch), findsOneWidget);
    });
  });

  testWidgets('Edit profile button', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ProfilePage()));
    expect(find.text(appLocalizations.editProfile), findsOneWidget);
    expect(find.widgetWithText(CustomCard, appLocalizations.editProfile),
        findsOneWidget);
  });

  testWidgets('LogOut button', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ProfilePage()));
    expect(find.text(appLocalizations.logOut), findsOneWidget);
    expect(find.widgetWithText(CustomCard, appLocalizations.logOut),
        findsOneWidget);
  });
}
