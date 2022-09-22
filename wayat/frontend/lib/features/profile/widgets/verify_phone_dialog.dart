import 'package:auto_route/auto_route.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:wayat/features/profile/controllers/verify_phone_dialog_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/common/widgets/buttons/text_button.dart';
import 'package:wayat/features/profile/widgets/pin_input_field.dart';

class VerifyPhoneNumberDialog extends StatefulWidget {
  final String phoneNumber;
  final Function callbackPhone;
  final VerifyPhoneDialogController controller;

  VerifyPhoneNumberDialog(
      {Key? key,
      required this.phoneNumber,
      required this.callbackPhone,
      controller})
      : controller = controller ?? VerifyPhoneDialogController(),
        super(key: key);

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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
          signOutOnSuccessfulVerification: false,
          linkWithExistingUser: false,
          onCodeSent: () {},
          onLoginSuccess:
              (UserCredential userCredential, bool autoVerified) async {
            widget.callbackPhone(widget.phoneNumber);
            AutoRouter.of(context).pop();
          },
          onLoginFailed:
              (FirebaseAuthException authException, StackTrace? stackTrace) {
            errorMsg =
                widget.controller.generateLoginFailedMessage(authException);
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
                    style: const TextStyle(
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
