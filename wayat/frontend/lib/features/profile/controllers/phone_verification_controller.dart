import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/widgets/verify_phone_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:mobx/mobx.dart';

part 'phone_verification_controller.g.dart';

// ignore: library_private_types_in_public_api
class PhoneVerificationController = _PhoneVerificationController
    with _$PhoneVerificationController;

/// Controller which contains methods and functions which validate phone number
abstract class _PhoneVerificationController with Store {
  /// Get current user session state from FireStore
  final MyUser user = GetIt.I.get<SessionState>().currentUser!;

  /// Initialize [phoneNumber] variable
  @observable
  String phoneNumber = "";

  /// Initialize [errorPhoneVerificationMsg] variable
  @observable
  String errorPhoneVerificationMsg = "";

  /// Initialize [errorPhoneFormat] variable
  @observable
  String errorPhoneFormat = "";

  /// If [validPhone] true, phone validation is successfull, if - false is failed
  @observable
  bool validPhone = false;

  /// Set new [phone] number
  @action
  void setNewPhoneNumber(String phone) {
    phoneNumber = phone;
  }

  /// Set valid [phone] number
  @action
  void setValidPhoneNumber(String phone) {
    phoneNumber = phone;
    validPhone = true;
  }

  /// Set error [msg]
  @action
  void setErrorPhoneMsg(String msg) {
    errorPhoneVerificationMsg = msg;
  }

  /// Validate new entered [textValue] phone number
  ///
  /// check phone number is not null
  /// check phone number length is correct
  /// check phone number is different of previous one
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

  /// On change phone number, call validation
  /// If [validPhone] true call [_submit]
  void onChangePhoneNumber(
      PhoneNumber phone, GlobalKey<FormState> formKey, BuildContext context) {
    if (formKey.currentState != null) {
      final validPhone = formKey.currentState!.validate();
      if (phone.completeNumber == user.phone ||
          phone.completeNumber == phoneNumber) return;
      if (validPhone) _submit(phone.completeNumber, context);
    }
  }

  /// Show verification dialog to get OTP sms
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
