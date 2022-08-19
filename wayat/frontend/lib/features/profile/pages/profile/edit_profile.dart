import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  XFile? currentSelectedImage;

  final ProfileState profileState = GetIt.I.get<ProfileState>();

  String name = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    name = GetIt.I.get<SessionState>().currentUser!.name;
    return Column(
      children: [
        _profileAppBar(),
        const SizedBox(height: 18),
        _buildProfileImage(),
        const SizedBox(height: 32),
        _nameTextField(),
        const SizedBox(height: 34.5),

        // TODO: Implement the Changing phone page
        // _changePhone(),
      ],
    );
  }

  Row _profileAppBar() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      _onPressedBackButton();
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black87, size: 16)),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    appLocalizations.profile,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await _onPressedSaveButton();
            },
            child: Text(
              appLocalizations.save,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              textAlign: TextAlign.right,
            ),
          )
        ],
      );

  void _onPressedBackButton() {
    profileState.setProfile(true);
    profileState.setEditProfile(false);
    profileState.setPreferences(false);
    profileState.setFaqs(false);
    profileState.setPrivacy(false);
  }

  Future<void> _onPressedSaveButton() async {
    bool changed = false;
    if (currentSelectedImage != null) {
      changed = await profileState.profileService
          .uploadProfileImage(currentSelectedImage);
    }
    if (name != "") {
      changed = await profileState.profileService.updateProfileName(name);
    }
    if (changed) {
      profileState.updateCurrentUser();
      _onPressedBackButton();
    }
  }

  Widget _buildProfileImage() {
    return Stack(alignment: Alignment.bottomRight, children: <Widget>[
      CircleAvatar(
          radius: 50.0,
          backgroundImage: (currentSelectedImage != null)
              ? FileImage(io.File(currentSelectedImage!.path)) as ImageProvider
              : NetworkImage(
                  GetIt.I.get<SessionState>().currentUser!.imageUrl)),
      InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (builder) => _getImageFromCameraOrGallary());
        },
        child: const Icon(Icons.camera_alt, color: Colors.black87, size: 30),
      ),
    ]);
  }

  Padding _nameTextField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintText:
                  '${appLocalizations.name}                                               ${name}',
            ),
            onChanged: ((text) {
              name = text;
            })),
      );

  Row _changePhone() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              appLocalizations.changePhone,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
                onTap: () {
                  //AutoRoute to change phone page
                },
                child: const Icon(Icons.arrow_forward,
                    color: Colors.black87, size: 16)),
          )
        ],
      );

  Widget _getImageFromCameraOrGallary() {
    return Container(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          Text(appLocalizations.chooseProfileFoto,
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton.icon(
                onPressed: () => _getFromSource(ImageSource.camera),
                icon: const Icon(
                  Icons.camera,
                  size: 50,
                ),
                label: Text(appLocalizations.camera)),
            TextButton.icon(
                onPressed: () => _getFromSource(ImageSource.gallery),
                icon: const Icon(
                  Icons.image,
                  size: 50,
                ),
                label: Text(appLocalizations.gallery)),
          ])
        ]));
  }

  void _getFromSource(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setState(() {
      currentSelectedImage = newImage;
    });
  }
}