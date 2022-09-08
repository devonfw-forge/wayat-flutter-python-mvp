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

  const VerifyPhoneNumberDialog({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberDialog> createState() =>
      _VerifyPhoneNumberDialogState();
}

class _VerifyPhoneNumberDialogState extends State<VerifyPhoneNumberDialog>
    with WidgetsBindingObserver {
  bool isVerified = false;

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
        signOutOnSuccessfulVerification: false,
        linkWithExistingUser: false,
        onCodeSent: () {},
        onLoginSuccess: (userCredential, autoVerified) async {},
        onLoginFailed: (authException, stackTrace) {},
        onError: (error, stackTrace) {},
        builder: (context, controller) {
          return _buildValidationAlertDialog(context, controller);
        },
      ),
    ));
  }

  Widget _buildValidationAlertDialog(context, controller) {
    return AlertDialog(
      //backgroundColor: Theme.of(context).primaryColor,
      title: Text(appLocalizations.verifyPhoneTitle),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 18),
      titlePadding: const EdgeInsets.only(top: 32, left: 32, right: 32),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220.0),
        //height: MediaQuery.of(context).size.height * 0.27,
        //width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getVerifyPhoneText(
                  appLocalizations.verifyPhoneText, widget.phoneNumber),
              const SizedBox(height: 32),
              _getVirifyTextfields(controller),
              _getVerifyResendCode(
                  appLocalizations.didnotReceiveCode, controller),
            ]),
      ),
      actionsPadding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      actions: [
        Column(
          children: [
            CustomFilledButton(
                text: appLocalizations.verify,
                enabled: true,
                onPressed: () {
                  if (isVerified) {
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
      ),
    );
  }

  Widget _getVirifyTextfields(controller) {
    return PinInputField(
      length: 6,
      onSubmit: (enteredOtp) async {
        final verified = await controller.verifyOtp(enteredOtp);
        if (verified) {
          isVerified =
              await GetIt.I.get<SessionState>().updatePhone(widget.phoneNumber);
          AutoRouter.of(context).pop();
        } else {
          debugPrint('Phone verification error! Invalid code!');
        }
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
    return Expanded(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
      ]),
    );
  }
}
