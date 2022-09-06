import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth_handler_demo/screens/custombutton.dart';
import 'package:phone_auth_handler_demo/screens/customtextbutton.dart';

class ChangePhoneValidationDialog extends StatelessWidget {
  static const id = 'ChangePhoneValidationDialog';

  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String newPhoneNumber;

  ChangePhoneValidationDialog({Key? key, required this.newPhoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildValidationAlertDialog(context);
  }

  AlertDialog _buildValidationAlertDialog(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Theme.of(context).primaryColor,
      title: Text('Verify phone number'),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 16),
      titlePadding: const EdgeInsets.all(32),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getVerifyPhoneText(
                  'Enter verification phone text', '+34600947886'),
              const SizedBox(height: 32),
              _getVirifyTextfields(context),
              const SizedBox(height: 32),
              _getVerifyResendCode('Did not receive code?'),
            ]),
      ),
      actionsPadding: const EdgeInsets.only(left: 15, right: 15),
      actions: [
        Column(
          children: [
            CustomFilledButton(text: 'Verify', enabled: true, onPressed: () {}),
            CustomTextButton(text: 'Cancel', onPressed: () {}),
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
            fontSize: 16));
  }

  Widget _getVerifyResendCode(String text) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(text,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              fontSize: 15)),
      TextButton(
          child: const Text(
            'Recend code?',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 15),
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
        _validationTextField(context, false),
      ],
    );
  }

  Widget _validationTextField(BuildContext context, bool autoFocus) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.13,
      width: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
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
