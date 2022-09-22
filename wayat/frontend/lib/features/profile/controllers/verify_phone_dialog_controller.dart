import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:wayat/lang/app_localizations.dart';

class VerifyPhoneDialogController {
  String generateLoginFailedMessage(FirebaseAuthException authException) {
    if (authException.code == "permission-denied") {
      return appLocalizations.phoneDeniedPermissions;
    } else if (authException.code == "invalid-verification-code") {
      return appLocalizations.phoneErrorCode;
    } else if (authException.code == "too-many-requests") {
      return appLocalizations.phoneErrorTooRequest;
    }
    return appLocalizations.phoneUnexpectedError;
  }
}
