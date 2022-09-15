import 'package:auto_route/auto_route.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/common/widgets/buttons/text_button.dart';
import 'package:wayat/features/profile/widgets/pin_input_field.dart';
import 'package:wayat/lang/app_localizations.dart';

class VerifyPhoneNumberDialog extends StatefulWidget {
  static const id = 'VerifyPhoneNumberScreen';
  final String phoneNumber;
  final Function callbackPhone;

  const VerifyPhoneNumberDialog({
    Key? key,
    required this.phoneNumber,
    required this.callbackPhone,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberDialog> createState() =>
      _VerifyPhoneNumberDialogState();
}

class _VerifyPhoneNumberDialogState extends State<VerifyPhoneNumberDialog>
    with WidgetsBindingObserver {
  String errorMsg = "";
  String enteredOtp = "";

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthProvider(
        child: FirebasePhoneAuthHandler(
          phoneNumber: widget.phoneNumber,
          autoRetrievalTimeOutDuration: Duration(seconds: 5),
          signOutOnSuccessfulVerification: false,
          linkWithExistingUser: false,
          onCodeSent: () {
            // debugPrint("DEBUG send code");
          },
          onLoginSuccess:
              (UserCredential userCredential, bool autoVerified) async {
            widget.callbackPhone(widget.phoneNumber);
          },
          onLoginFailed:
              (FirebaseAuthException authException, StackTrace? stackTrace) {
            if (authException.code == "permission-denied") {
              errorMsg = "Permisos denegados";
            } else if (authException.code == "invalid-verification-code") {
              errorMsg = "Codigo erroneo, solicita otro codigo";
            } else if (authException.code == "too-many-requests") {
              errorMsg =
                  "Se ha excedido el numero de intentos para este numero";
            } else {
              errorMsg =
                  "Error inesperado, por favor intentalo otra vez mas tarde";
            }
            setState(() {});
          },
          onError: (Object error, StackTrace stackTrace) {},
          builder: (context, controller) {
            return _buildValidationAlertDialog(context, controller);
          },
        ),
      ),
    );
  }

  Widget _buildValidationAlertDialog(
      BuildContext context, FirebasePhoneAuthController controller) {
    return SingleChildScrollView(
      child: AlertDialog(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(appLocalizations.verifyPhoneTitle),
          IconButton(
              onPressed: () => AutoRouter.of(context).pop(),
              icon: const Icon(Icons.close))
        ]),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 18),
        titlePadding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getVerifyPhoneText(
                appLocalizations.verifyPhoneText, widget.phoneNumber),
            const SizedBox(height: 32),
            _getVerifyTextfields(controller),
            const SizedBox(height: 32),
            _getVerifyResendCode(
                appLocalizations.didnotReceiveCode, controller),
            errorMsg.isEmpty
                ? const SizedBox(height: 16)
                : Text(
                    textAlign: TextAlign.center,
                    errorMsg,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
          ],
        ),
        actionsPadding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
        actions: [
          Column(
            children: [
              CustomFilledButton(
                  text: appLocalizations.verify,
                  enabled: true,
                  onPressed: () async {
                    final verified = await controller.verifyOtp(enteredOtp);
                    if (verified) {
                      AutoRouter.of(context).pop();
                    }
                  }),
              CustomTextButton(
                  text: appLocalizations.cancel,
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  }),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
      ),
    );
  }

  Widget _getVerifyTextfields(FirebasePhoneAuthController controller) {
    return PinInputField(
      length: 6,
      onSubmit: (otp) async {
        enteredOtp = otp;
      },
    );
  }

  Widget _getVerifyPhoneText(String text, String userPhone) {
    return Text('$text $userPhone',
        textAlign: TextAlign.center,
        maxLines: 3,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.black87,
            fontSize: 18));
  }

  Widget _getVerifyResendCode(String text, controller) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(text,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontSize: 14)),
          TextButton(
              child: Text(
                appLocalizations.resendCode,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 15),
              ),
              onPressed: () async {
                await controller.sendOTP();
              })
        ]);
  }
}
