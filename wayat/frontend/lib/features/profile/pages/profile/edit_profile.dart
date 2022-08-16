import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/lang/app_localizations.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../domain/contact/contact.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final Contact contact;
  XFile? currentSelectedImage;

  final textController = TextEditingController();
  final SessionState controller = GetIt.I.get<SessionState>();

  @override
  void initState() {
    super.initState();
    textController.addListener((() {
      contact.name = textController.text;
    }));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _profileAppBar(),
            const SizedBox(height: 32),
            _buildProfileImage(),
            const SizedBox(height: 16),
            _nameTextField(),
            _changePhone(),
            _changePassword(),
          ],
        ));
  }

  Row _profileAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Positioned(
              left: 20,
              child: InkWell(
                  onTap: () async {
                    controller.goToProfile(true);
                  },
                  child: const Icon(Icons.arrow_back,
                      color: Colors.black87, size: 16))),
          Text(
            appLocalizations.profile,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
          Positioned(
              right: 20,
              child: TextButton(
                onPressed: () {
                  //Save data to Firestore
                },
                child: Text(appLocalizations.save),
              ))
        ],
      );

  Widget _buildProfileImage() {
    return Stack(alignment: Alignment.center, children: <Widget>[
      CircleAvatar(
          radius: 95.0,
          backgroundImage:
              NetworkImage(contact.imageUrl)), //Need to paste picked image
      Positioned(
          top: 10,
          child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) => _getImageFromCameraOrGallary());
              },
              child: const Icon(Icons.camera_alt,
                  color: Colors.black87, size: 45))),
    ]);
  }

  Padding _nameTextField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: TextField(
            controller: textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintText: appLocalizations.name,
            ),
            onChanged: ((text) {})),
      );

  Row _changePhone() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLocalizations.changePhone,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
          Positioned(
              right: 20,
              child: InkWell(
                  onTap: () {
                    //AutoRoute to change phone page
                  },
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.black87, size: 16)))
        ],
      );

  Row _changePassword() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLocalizations.changePhone,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
          Positioned(
              right: 20,
              child: InkWell(
                  onTap: () {
                    //AutoRoute to change password page
                  },
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.black87, size: 16)))
        ],
      );

  Widget _getImageFromCameraOrGallary() {
    return Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          Text(appLocalizations.chooseProfileFoto,
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton.icon(
                onPressed: () => _getFromSource(ImageSource.camera),
                icon: const Icon(Icons.camera),
                label: Text(appLocalizations.camera)),
            TextButton.icon(
                onPressed: () => _getFromSource(ImageSource.gallery),
                icon: const Icon(Icons.image),
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
