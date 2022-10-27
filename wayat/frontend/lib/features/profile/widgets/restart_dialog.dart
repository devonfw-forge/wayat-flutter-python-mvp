import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/lang/app_localizations.dart';

class RestartDialog extends StatelessWidget {
  const RestartDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRestartIosDialog(context);
  }

  /// Restart the app in iOS information dialog
  ///
  /// Information dialog for the user, that tells them about manually restarting iOS application
  SingleChildScrollView _buildRestartIosDialog(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        alignment: Alignment.center,
        title: Text(appLocalizations.iosChangeLangTitle),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 16),
        titlePadding: const EdgeInsets.all(32),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 70,
            minHeight: 50,
            maxWidth: 400,
            maxHeight: 400,
          ),
          child: _getRestartIosDialogText(appLocalizations.iosChangeLangMsg),
        ),
        actionsPadding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
        actions: [
          Column(
            children: [
              CustomFilledButton(
                  text: 'Ok',
                  enabled: true,
                  onPressed: () {
                    Navigator.of(context).pop();
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
