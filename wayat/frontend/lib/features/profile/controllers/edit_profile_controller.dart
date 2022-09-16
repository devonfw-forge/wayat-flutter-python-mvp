import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/features/profile/widgets/verify_phone_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
import 'package:mobx/mobx.dart';

part 'edit_profile_controller.g.dart';

class EditProfileController = _EditProfileController
    with _$EditProfileController;

abstract class _EditProfileController with Store {
  final MyUser user = GetIt.I.get<SessionState>().currentUser!;
  final ProfileState profileState = GetIt.I.get<ProfileState>();

  ProfileServiceImpl profileService = ProfileServiceImpl();

  @observable
  String phoneNumber = "";

  @observable
  String errorPhoneVerificationMsg = "";

  @observable
  String errorPhoneFormat = "";

  @observable
  String? name;

  @observable
  XFile? currentSelectedImage;

  @observable
  bool validPhone = false;

  @action
  void setName(String newName) {
    name = newName;
  }

  @action
  void setNewPhoneNumber(String phone) {
    phoneNumber = phone;
  }

  @action
  void setErrorPhoneMsg(String msg) {
    errorPhoneVerificationMsg = msg;
  }

  @action
  void setNewImage(XFile? image) {
    currentSelectedImage = image;
  }

  void onPressedBackButton() {
    phoneNumber = "";
    profileState.setCurrentPage(ProfileCurrentPages.profile);
  }

  Future<void> onPressedSaveButton() async {
    profileState.setCurrentPage(ProfileCurrentPages.profile);
    if (name != null ? name!.replaceAll(" ", "").isNotEmpty : false) {
      await profileState.updateCurrentUserName(name!);
    }

    if (currentSelectedImage != null) {
      await profileState.updateUserImage(currentSelectedImage!);
    }
    if (phoneNumber.isNotEmpty) {
      await GetIt.I.get<SessionState>().updatePhone(phoneNumber);
    }
  }

  @action
  String validatePhoneNumber(textValue) {
    if (textValue.number.isEmpty) {
      errorPhoneFormat = appLocalizations.phoneEmpty;
    } else if (textValue.completeNumber.length < 12) {
      errorPhoneFormat = appLocalizations.phoneIncorrect;
    } else if (textValue.completeNumber == user.phone) {
      errorPhoneFormat = appLocalizations.phoneDifferent;
    } else {
      errorPhoneFormat = "";
    }
    return errorPhoneFormat;
  }

  void onChangePhoneNumber(
      PhoneNumber phone, GlobalKey<FormState> formKey, BuildContext context) {
    if (formKey.currentState != null) {
      final validPhone = formKey.currentState!.validate();
      if (phone.completeNumber == user.phone ||
          phone.completeNumber == phoneNumber) return;
      if (validPhone) _submit(phone.completeNumber, context);
    }
  }

  void _submit(String newPhone, BuildContext context) {
    FocusScope.of(context).unfocus();
    if (errorPhoneVerificationMsg == '') {
      setNewPhoneNumber("");
      showDialog(
          context: context,
          builder: (context) {
            return VerifyPhoneNumberDialog(
                phoneNumber: newPhone, callbackPhone: setNewPhoneNumber);
          });
    }
  }

  Future getFromSource(ImageSource source, BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setNewImage(newImage);
    Navigator.of(context).pop();
  }
}
