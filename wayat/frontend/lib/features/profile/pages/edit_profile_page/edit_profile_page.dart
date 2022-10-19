import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_field.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

import 'package:wayat/services/common/platform/platform_service_libw.dart';

class EditProfilePage extends StatefulWidget {
  final EditProfileController controller;
  final PlatformService platformService;

  EditProfilePage(
      {Key? key,
      EditProfileController? controller,
      PlatformService? platformService})
      : controller = controller ?? EditProfileController(),
        platformService = platformService ?? PlatformService(),
        super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final MyUser user = GetIt.I.get<UserState>().currentUser!;

  TextStyle _textStyle(Color color, double size) =>
      TextStyle(fontWeight: FontWeight.w500, color: color, fontSize: size);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/profile');
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _profileAppBar(),
              _buildEditProfileImage(),
              const SizedBox(height: 32),
              _nameTextField(),
              const SizedBox(height: 34.5),
              if (widget.platformService.isMobile) PhoneVerificationField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileAppBar() {
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
                    context.go('/profile');
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black87)),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  appLocalizations.profile,
                  style: _textStyle(Colors.black87, 16),
                ),
              ),
            ],
          ),
          Observer(
            builder: (_) => TextButton(
              onPressed: () async =>
                  await widget.controller.onPressedSaveButton(),
              child: Text(
                appLocalizations.save,
                style: _textStyle(ColorTheme.primaryColor, 16),
                textAlign: TextAlign.right,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEditProfileImage() {
    return Stack(alignment: Alignment.bottomRight, children: <Widget>[
      Observer(
        builder: (_) {
          return Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (widget.controller.currentSelectedImage != null)
                    ? FileImage(io.File(
                            widget.controller.currentSelectedImage!.path))
                        as ImageProvider
                    : NetworkImage(
                        GetIt.I.get<UserState>().currentUser!.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(
                color: Colors.black87,
                width: 7.0,
              ),
            ),
          );
        },
      ),
      InkWell(
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (builder) => _getImageFromCameraOrGallary()),
        child: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 28,
            child: Icon(Icons.edit_outlined, color: Colors.white)),
      ),
    ]);
  }

  Container _nameTextField() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black87,
            width: 1,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(appLocalizations.name,
                style: _textStyle(Colors.black87, 18)),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
                cursorColor: Colors.black87,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: user.name,
                    hintStyle: _textStyle(Colors.black38, 18)),
                onChanged: ((text) => widget.controller.setName(text))),
          )),
        ]),
      );

  Widget _getImageFromCameraOrGallary() {
    return Observer(
      builder: (_) => Container(
          height: MediaQuery.of(context).size.height / 8,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(children: [
            Text(appLocalizations.chooseProfileFoto,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              TextButton.icon(
                  onPressed: () {
                    widget.controller.getFromSource(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.black87,
                  ),
                  label: Text(
                    appLocalizations.camera,
                    style: const TextStyle(color: Colors.black87),
                  )),
              TextButton.icon(
                  onPressed: () {
                    widget.controller.getFromSource(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.image,
                    size: 30,
                    color: Colors.black87,
                  ),
                  label: Text(
                    appLocalizations.gallery,
                    style: const TextStyle(color: Colors.black87),
                  )),
            ])
          ])),
    );
  }
}
