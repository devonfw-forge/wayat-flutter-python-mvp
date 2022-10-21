import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/common/widgets/phone_verification/verify_phone_dialog_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

import '../../../test_common/test_app.dart';

void main() async {
  testWidgets('Check error messages on Login Failed', (tester) async {
    await tester.pumpWidget(TestApp.createApp());
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
