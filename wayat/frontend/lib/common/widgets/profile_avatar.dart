import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';

class ProfileAvatar extends StatelessWidget {
  final Function() onPress;
  ImageProvider<Object>? uploadedImage;
  bool isEdit;

  ProfileAvatar({
    super.key,
    required this.onPress,
    this.isEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(isEdit.toString());
    return Stack(children: <Widget>[
      Center(
        child: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (uploadedImage != null)
                  ? uploadedImage!
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
      ),
      Visibility(visible: isEdit, child: _editIcon())
    ]);
  }

  Widget _editIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 75),
      child: Center(
        child: InkWell(
          onTap: () {
            onPress();
          },
          child: const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 28,
              child: Icon(
                Icons.edit_outlined,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
