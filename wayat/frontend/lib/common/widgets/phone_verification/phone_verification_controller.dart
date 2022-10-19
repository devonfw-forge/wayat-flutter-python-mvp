import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/common/widgets/phone_verification/verify_phone_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:mobx/mobx.dart';

part 'phone_verification_controller.g.dart';

// ignore: library_private_types_in_public_api
class PhoneVerificationController = _PhoneVerificationController
    with _$PhoneVerificationController;

/// Controller used to validate the phone number
abstract class _PhoneVerificationController with Store {
  /// Gets current user
  final MyUser user = GetIt.I.get<UserState>().currentUser!;

  /// Stores the user's phone number
  @observable
  PhoneNumber? phoneNumber;

  /// Stores the error format
  @observable
  String? errorPhoneVerification;

  @computed
  bool get isValidPhone =>
      errorPhoneVerification == null &&
      phoneNumber != null &&
      phoneNumber!.completeNumber !=
          GetIt.I.get<UserState>().currentUser!.phone;

  /// Validates the new phone number in [textValue]
  ///
  /// Checks phone number is not null
  /// Checks phone number is different from previous one
  @action
  String? validatePhoneNumber(PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) {
      errorPhoneVerification = appLocalizations.phoneEmpty;
    } else {
      Country country = countries
          .firstWhere((element) => element.code == phone.countryISOCode);
      if (phone.number.length < country.maxLength) {
        errorPhoneVerification = appLocalizations.phoneIncorrect;
      } else if (phone.completeNumber ==
          GetIt.I.get<UserState>().currentUser!.phone) {
        errorPhoneVerification = appLocalizations.phoneDifferent;
      } else {
        errorPhoneVerification = null;
      }
    }

    return errorPhoneVerification;
  }

  /// Shows verification dialog to get OTP sms
  void sendSMS(BuildContext context, {Function? onValidated}) {
    if (isValidPhone) {
      showDialog(
        context: context,
        builder: (context) => VerifyPhoneNumberDialog(
          phoneNumber: phoneNumber!,
          callbackController: (String? error) {
            errorPhoneVerification = error;
            if (error != null) {
              phoneNumber = null;
            } else {
              if (onValidated != null) {
                onValidated();
              }
            }
            Navigator.of(context).pop();
          },
        ),
      );
    }
    // Removes the keyboard
    FocusScope.of(context).unfocus();
  }

  String getISOCode() {
    return countries
        .firstWhere(
            (element) =>
                element.dialCode == user.phonePrefix.replaceAll("+", ""),
            orElse: () => countries[0])
        .code;
  }
}
