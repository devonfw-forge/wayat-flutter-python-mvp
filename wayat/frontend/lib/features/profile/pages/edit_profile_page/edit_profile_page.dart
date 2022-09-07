import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/features/profile/widgets/verify_phone_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final MyUser user = GetIt.I.get<SessionState>().currentUser!;
  final ProfileState profileState = GetIt.I.get<ProfileState>();
  final EditProfileController controller = EditProfileController();

  XFile? currentSelectedImage;
  String? name;
  bool isVisible = false;
  final String _errorPhoneMsg = "";
  final int _otpCode = 0;

  TextStyle _textStyle(Color color, double size) =>
      TextStyle(fontWeight: FontWeight.w500, color: color, fontSize: size);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _profileAppBar(),
          _buildEditProfileImage(),
          const SizedBox(height: 32),
          _nameTextField(),
          const SizedBox(height: 34.5),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _phoneTextField(),
          )
        ],
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
                    controller.onPressedBackButton();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black87)),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(appLocalizations.profile,
                    style: _textStyle(Colors.black87, 16)),
              ),
            ],
          ),
          TextButton(
            onPressed: () async {
              await controller.onPressedSaveButton(name, currentSelectedImage);
            },
            child: Text(
              appLocalizations.save,
              style: _textStyle(ColorTheme.primaryColor, 16),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEditProfileImage() {
    return Stack(alignment: Alignment.bottomRight, children: <Widget>[
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: (currentSelectedImage != null)
                ? FileImage(io.File(currentSelectedImage!.path))
                    as ImageProvider
                : NetworkImage(
                    GetIt.I.get<SessionState>().currentUser!.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
          border: Border.all(
            color: Colors.black87,
            width: 7.0,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (builder) => _getImageFromCameraOrGallary());
        },
        child: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 28,
            child: Icon(
              Icons.edit_outlined,
              color: Colors.white,
            )),
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
                onChanged: ((text) {
                  name = text;
                })),
          )),
        ]),
      );

  IntlPhoneField _phoneTextField() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.setSettings(appVerificationDisabledForTesting: true);
    return IntlPhoneField(
      // Only numbers are allowed as input
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
          errorText: _errorPhoneMsg != "" ? _errorPhoneMsg : null,
          labelText: user.phone,
          labelStyle: _textStyle(Colors.black87, 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'ES',
      onChanged: (phone) async {
        if (phone.completeNumber.length == 12) {
          showDialog(
              context: context,
              builder: (context) {
                return VerifyPhoneNumberDialog(
                    phoneNumber: phone.completeNumber);
              });
        }
      },
    );
  }

  Widget _getImageFromCameraOrGallary() {
    return Container(
        height: MediaQuery.of(context).size.height / 8,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          Text(appLocalizations.chooseProfileFoto,
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton.icon(
                onPressed: () => _getFromSource(ImageSource.camera),
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
                onPressed: () => _getFromSource(ImageSource.gallery),
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
        ]));
  }

  void _getFromSource(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setState(() {
      currentSelectedImage = newImage;
    });
    AutoRouter.of(context).pop();
  }
}
