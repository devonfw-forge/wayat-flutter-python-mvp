import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/theme/text_style.dart';
import 'package:wayat/common/widgets/profile_avatar.dart';
import 'package:wayat/features/authentication/page/change_phone_validation_page.dart';
import 'package:wayat/features/profile/selector/profile_pages.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileState profileState = GetIt.I.get<ProfileState>();
  final SessionState userSession = GetIt.I.get<SessionState>();
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _validPhone = false;
  final String _errorPhoneMsg = "";

  XFile? currentSelectedImage;
  String name = GetIt.I.get<SessionState>().currentUser!.name;
  String phone = GetIt.I.get<SessionState>().currentUser!.phone;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _profileAppBar(),
          ProfileAvatar(
            isEdit: true,
            onPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (builder) => _getImageFromCameraOrGallary());
            },
          ),
          //_buildEditProfileImage(),
          const SizedBox(height: 32),
          _nameInput(appLocalizations.name, name),
          const SizedBox(height: 34.5),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _phoneInput(),
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
                    _onPressedBackButton();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black87)),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(appLocalizations.profile,
                    style: TextStyleTheme.primaryTextStyle_16),
              ),
            ],
          ),
          TextButton(
            onPressed: () async {
              await _onPressedSaveButton();
            },
            child: Text(
              appLocalizations.save,
              style: TextStyleTheme.saveButtonTextStyle_16,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  Widget _nameInput(String title, String hintText) {
    return Container(
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
          child: Text(title, style: TextStyleTheme.primaryTextStyle_18),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyleTheme.primaryTextStyle_18),
            onChanged: ((text) {
              setState(() {});
              hintText = text;
            }),
          ),
        )),
      ]),
    );
  }

  IntlPhoneField _phoneInput() {
    return IntlPhoneField(
      // Only numbers are allowed as input
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
          errorText: _errorPhoneMsg != "" ? _errorPhoneMsg : null,
          labelText: userSession.currentUser!.phone.substring(3),
          labelStyle: TextStyleTheme.primaryTextStyle_16,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'ES',
      onSubmitted: (phone) {
        //TODO: Have an error here on validation... fix later
        // _validPhone = _formKey.currentState!.validate();
        _validPhone = true;
        if (_validPhone) _showVerificationAlertDialog();
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
    Navigator.pop(context);
  }

  void _onPressedBackButton() {
    profileState.setCurrentPage(ProfilePages.profile);
  }

  Future<void> _onPressedSaveButton() async {
    _onPressedBackButton();

    if (name != "") {
      await profileState.updateCurrentUserName(name);
    }

    if (currentSelectedImage != null) {
      await profileState.updateUserImage(currentSelectedImage!);
    }
  }

  void _showVerificationAlertDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return ChangePhoneValidationPage();
        });
  }
}
