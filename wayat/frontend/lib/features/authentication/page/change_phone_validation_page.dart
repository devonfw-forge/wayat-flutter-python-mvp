import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/common/widgets/buttons/text_button.dart';
import 'package:wayat/lang/app_localizations.dart';

class ChangePhoneValidationPage extends StatelessWidget {
  ChangePhoneValidationPage({Key? key}) : super(key: key);

  final SessionState userSession = GetIt.I.get<SessionState>();

  @override
  Widget build(BuildContext context) {
    // if (defaultTargetPlatform == TargetPlatform.iOS) {
    //   return _buildValidationiOSAlertDialog(context);
    // }
    return _buildValidationAlertDialog(context);
  }

  //TODO: iOS AlertDialog of verify phone
  CupertinoAlertDialog _buildValidationiOSAlertDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(appLocalizations.verifyPhoneTitle),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.32,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getVerifyPhoneText(appLocalizations.verifyPhoneText,
                  userSession.currentUser!.phone),
              const SizedBox(height: 32),
              _getVirifyTextfields(context),
              const SizedBox(height: 32),
              _getVerifyResendCode(appLocalizations.didnotReceiveCode),
            ]),
      ),
      actions: [
        Column(
          children: [
            CustomFilledButton(
                text: appLocalizations.verify, enabled: true, onPressed: () {}),
            CustomTextButton(
                text: appLocalizations.cancel,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ],
    );
  }

  //TODO: Android AlertDialog of verify phone
  AlertDialog _buildValidationAlertDialog(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Theme.of(context).primaryColor,
      title: Text(appLocalizations.verifyPhoneTitle),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 18),
      titlePadding: const EdgeInsets.all(32),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.32,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getVerifyPhoneText(appLocalizations.verifyPhoneText,
                  userSession.currentUser!.phone),
              const SizedBox(height: 32),
              _getVirifyTextfields(context),
              const SizedBox(height: 32),
              _getVerifyResendCode(appLocalizations.didnotReceiveCode),
            ]),
      ),
      actionsPadding: const EdgeInsets.only(left: 32, right: 32),
      actions: [
        Column(
          children: [
            CustomFilledButton(
                text: appLocalizations.verify, enabled: true, onPressed: () {}),
            CustomTextButton(
                text: appLocalizations.cancel,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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

  Widget _getVerifyResendCode(String text) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(text,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              fontSize: 16)),
      TextButton(
          child: Text(
            appLocalizations.resendCode,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 16),
          ),
          onPressed: () {})
    ]);
  }

  Widget _getVirifyTextfields(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _validationTextField(context, true),
        _validationTextField(context, false),
        _validationTextField(context, false),
        _validationTextField(context, false),
        _validationTextField(context, false),
      ],
    );
  }

  Widget _validationTextField(BuildContext context, bool autoFocus) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: autoFocus,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLines: 1,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
