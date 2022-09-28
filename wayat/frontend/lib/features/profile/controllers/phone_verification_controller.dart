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

/// Controller used to validate the phone number
abstract class _PhoneVerificationController with Store {
  /// Gets current user
  final MyUser user = GetIt.I.get<SessionState>().currentUser!;

  /// Stores the user's phone number
  @observable
  String phoneNumber = "";

  /// Stores the error message if the verification goes wrong
  @observable
  String errorPhoneVerificationMsg = "";

  /// Stores the error format
  @observable
  String errorPhoneFormat = "";

  /// Whether the phone validation is successful
  @observable
  bool validPhone = false;

  /// Sets new [phone] number
  @action
  void setNewPhoneNumber(String phone) {
    phoneNumber = phone;
  }

  /// Sets valid [phone] number
  @action
  void setValidPhoneNumber(String phone) {
    phoneNumber = phone;
    validPhone = true;
  }

  /// Sets error [msg]
  @action
  void setErrorPhoneMsg(String msg) {
    errorPhoneVerificationMsg = msg;
  }

  /// Validates the new phone number in [textValue]
  ///
  /// Checks phone number is not null
  /// Checks phone number length is correct
  /// Checks phone number is different from previous one
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

  /// When the phone number changes, validate it
  /// If it is valid, call [_submit]
  void onChangePhoneNumber(
      PhoneNumber phone, GlobalKey<FormState> formKey, BuildContext context) {
    if (formKey.currentState != null) {
      final validPhone = formKey.currentState!.validate();
      if (phone.completeNumber == user.phone ||
          phone.completeNumber == phoneNumber) return;
      if (validPhone) _submit(phone.completeNumber, context);
    }
  }

  /// Shows verification dialog to get OTP sms
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
        },
      );
    }
  }
}
