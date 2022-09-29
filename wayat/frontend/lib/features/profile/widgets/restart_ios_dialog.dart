import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/lang/app_localizations.dart';

class RestartIosDialog extends StatelessWidget {
  const RestartIosDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRestartIosDialog(context);
  }

  /// Restart the app in iOS information dialog
  ///
  /// Information dialog for the user, that tells them about manually restarting iOS application
  AlertDialog _buildRestartIosDialog(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Theme.of(context).primaryColor,
      title: Text(appLocalizations.iosChangeLangTitle),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 16),
      titlePadding: const EdgeInsets.all(32),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getRestartIosDialogText(appLocalizations.iosChangeLangMsg),
              ]),
        ),
      ),
      actionsPadding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      actions: [
        Column(
          children: [
            CustomFilledButton(
                text: 'Ok',
                enabled: true,
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
    );
  }

  Widget _getRestartIosDialogText(String text) {
    return Text(text,
        textAlign: TextAlign.center,
        maxLines: 5,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.black87,
            fontSize: 16));
  }
}
