import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/widgets/phoneVerificationField/verify_phone_dialog_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  GetIt.I.registerSingleton<LangSingleton>(LangSingleton());

  Widget createApp() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
    );
  }

  testWidgets('Check error messages on Login Failed', (tester) async {
    await tester.pumpWidget(createApp());
    VerifyPhoneDialogController controller = VerifyPhoneDialogController();
    expect(
        controller.generateLoginFailedMessage(
            FirebaseAuthException(code: "permission-denied")),
        appLocalizations.phoneDeniedPermissions);

    expect(
        controller.generateLoginFailedMessage(
            FirebaseAuthException(code: "invalid-verification-code")),
        appLocalizations.phoneErrorCode);

    expect(
        controller.generateLoginFailedMessage(
            FirebaseAuthException(code: "too-many-requests")),
        appLocalizations.phoneErrorTooRequest);

    expect(
        controller.generateLoginFailedMessage(
            FirebaseAuthException(code: "any-other-code")),
        appLocalizations.phoneUnexpectedError);
  });
}
