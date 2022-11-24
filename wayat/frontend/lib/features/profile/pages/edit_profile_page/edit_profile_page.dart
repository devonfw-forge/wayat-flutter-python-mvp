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

import 'package:wayat/services/common/platform/platform_service_libw.dart';

class EditProfilePage extends StatefulWidget {
  final EditProfileController controller;
  final PlatformService platformService = GetIt.I.get<PlatformService>();

  EditProfilePage({Key? key, EditProfileController? controller})
      : controller = controller ?? EditProfileController(),
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.platformService.isDesktopOrWeb)
                const SizedBox(
                  height: 20,
                ),
              ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: _profileAppBar()),
              _buildEditProfileImage(),
              const SizedBox(height: 32),
              ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: _nameTextField()),
              const SizedBox(height: 34.5),
              if (widget.platformService.isMobile)
                ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: PhoneVerificationField()),
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
                  splashRadius: 24,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 24,
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
              onPressed: () {
                widget.controller.onPressedSaveButton();
                context.go('/profile');
              },
              child: Text(
                appLocalizations.save,
                style: _textStyle(ColorTheme.primaryColor, 17),
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
                    ? Image.memory(widget.controller.currentSelectedImageBytes!)
                        .image
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
        onTap: () {
          if (widget.platformService.isWeb) {
            widget.controller.getFromSource(ImageSource.gallery);
          } else {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  if (widget.platformService.isDesktop) {
                    return _getImageFromCameraOrGalleryDesktop();
                  } else {
                    return _getImageFromCameraOrGalleryMobile();
                  }
                });
          }
        },
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

  Widget _getImageFromCameraOrGalleryMobile() {
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

  Widget _getImageFromCameraOrGalleryDesktop() {
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
                    widget.controller.getImageDesktop();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.folder,
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
