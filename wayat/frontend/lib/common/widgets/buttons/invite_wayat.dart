import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/app_localizations.dart';

class CustomInviteWayat extends StatelessWidget {
  final void Function() onCopyInvitation;
  const CustomInviteWayat({required this.onCopyInvitation, Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorTheme.secondaryColor),
        child: TextButton(
          onPressed: onCopyInvitation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLocalizations.inviteContacts,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.open_in_new_sharp,
                size: 24,
                color: ColorTheme.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
