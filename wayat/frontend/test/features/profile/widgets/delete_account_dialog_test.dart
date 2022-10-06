import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/buttons/text_button.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/widgets/delete_account_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'delete_account_dialog_test.mocks.dart';

@GenerateMocks([UserState, ProfileController])
void main() async {
  final MockUserState mockUserState = MockUserState();
  final MockProfileController mockProfileController = MockProfileController();
  late MyUser user;

  setUpAll(() {
    HttpOverrides.global = null;
    user = MyUser(
        id: "7",
        name: "testCurrentUser",
        email: "testCurrentUser@capg.com",
        imageUrl: "http://example.com",
        phone: "777777777",
        onboardingCompleted: true,
        shareLocationEnabled: true);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<UserState>(mockUserState);
    when(mockUserState.currentUser).thenAnswer((_) => user);
    GetIt.I.registerSingleton<ProfileController>(mockProfileController);
  });

  Widget createApp(Widget body) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('Delete account dialog is correct', (tester) async {
    await tester.pumpWidget(createApp(DeleteAccountDialog()));
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Delete account dialog has a correct title', (tester) async {
    await tester.pumpWidget(createApp(DeleteAccountDialog()));
    expect(find.text(appLocalizations.deleteAccount), findsOneWidget);
  });

  testWidgets('Delete account dialog has a correct text', (tester) async {
    await tester.pumpWidget(createApp(DeleteAccountDialog()));
    expect(find.text(appLocalizations.deleteAccountText), findsOneWidget);
  });

  testWidgets('Delete account dialog has button Verify', (tester) async {
    await tester.pumpWidget(createApp(DeleteAccountDialog()));
    expect(find.byType(CustomTextButton), findsOneWidget);
    expect(find.text(appLocalizations.delete), findsOneWidget);
  });

  testWidgets('Delete account dialog has button Cancel', (tester) async {
    await tester.pumpWidget(createApp(DeleteAccountDialog()));
    expect(find.byType(CustomTextButton), findsOneWidget);
    expect(find.text(appLocalizations.cancel), findsOneWidget);
  });
}
