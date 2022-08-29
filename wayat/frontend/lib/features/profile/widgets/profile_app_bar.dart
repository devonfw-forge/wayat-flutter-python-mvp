import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

Widget profileAppBar(XFile? currentSelectedImage) {
  final EditProfileController controller = EditProfileController();

  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                splashRadius: 25,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 25,
                onPressed: () {
                  controller.onPressedBackButton();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black87)),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(appLocalizations.profile,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 16)),
            ),
          ],
        ),
        TextButton(
          onPressed: () async {
            await controller.onPressedSaveButton(currentSelectedImage);
          },
          child: Text(
            appLocalizations.save,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorTheme.primaryColor,
                fontSize: 16),
            textAlign: TextAlign.right,
          ),
        )
      ],
    ),
  );
}
