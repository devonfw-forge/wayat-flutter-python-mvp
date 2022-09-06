import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCodeDialog extends StatelessWidget {
  String newPhoneNumber;

  VerificationCodeDialog({Key? key, required this.newPhoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildValidationAlertDialog(context);
  }

  AlertDialog _buildValidationAlertDialog(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Theme.of(context).primaryColor,
      title: const Text('Verify your phone'),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 18),
      titlePadding: const EdgeInsets.all(32),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              _getVirifyTextfields(context),
            ]),
      ),
      actionsPadding: const EdgeInsets.only(left: 32, right: 32),
      actions: [
        Column(children: [
          TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.white,
              ),
              onPressed: (() {}),
              child: const Text('Verify')),
          TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.white,
              ),
              onPressed: (() {}),
              child: const Text('Cancel')),
        ])
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
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
