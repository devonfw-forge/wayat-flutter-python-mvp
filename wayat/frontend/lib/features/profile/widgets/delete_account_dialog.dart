import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/common/widgets/buttons/text_button.dart';
import 'package:wayat/lang/app_localizations.dart';

class DeleteAccountDialog extends StatelessWidget {
  final UserState userState = GetIt.I.get<UserState>();
  final ProfileController profileController = GetIt.I.get<ProfileController>();

  DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDeleteAccountAlertDialog(context);
  }

  /// Delete account dialog
  ///
  /// The user needs to press [Delete] or [Cancel] deleting account
  AlertDialog _buildDeleteAccountAlertDialog(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Theme.of(context).primaryColor,
      title: Text(appLocalizations.deleteAccount),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 16),
      titlePadding: const EdgeInsets.all(32),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getDeleteAccountText(appLocalizations.deleteAccountText),
              ]),
        ),
      ),
      actionsPadding: const EdgeInsets.only(left: 32, right: 32),
      actions: [
        Column(
          children: [
            CustomFilledButton(
                text: appLocalizations.delete,
                enabled: true,
                onPressed: () {
                  AutoRouter.of(context).pop();
                  userState.logOut();
                  userState.deleteUser();
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
    );
  }

  Widget _getDeleteAccountText(String text) {
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
