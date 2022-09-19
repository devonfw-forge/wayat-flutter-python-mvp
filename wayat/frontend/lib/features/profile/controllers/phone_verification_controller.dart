import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/widgets/verify_phone_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:mobx/mobx.dart';

part 'phone_verification_controller.g.dart';

class PhoneVerificationController = _PhoneVerificationController
    with _$PhoneVerificationController;

abstract class _PhoneVerificationController with Store {
  final MyUser user = GetIt.I.get<SessionState>().currentUser!;
  final ProfileState profileState = GetIt.I.get<ProfileState>();

  @observable
  String phoneNumber = "";

  @observable
  String errorPhoneVerificationMsg = "";

  @observable
  String errorPhoneFormat = "";

  @observable
  bool validPhone = false;

  @action
  void setNewPhoneNumber(String phone) {
    phoneNumber = phone;
  }

  @action
  void setValidPhoneNumber(String phone) {
    phoneNumber = phone;
    validPhone = true;
  }

  @action
  void setErrorPhoneMsg(String msg) {
    errorPhoneVerificationMsg = msg;
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
      validPhone = false;
      setNewPhoneNumber("");
      showDialog(
          context: context,
          builder: (context) {
            return VerifyPhoneNumberDialog(
                phoneNumber: newPhone, callbackPhone: setValidPhoneNumber);
          });
    }
  }
}
