import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/common/widgets/phoneVerificationField/phone_verification_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

class PhoneVerificationField extends StatelessWidget {
  final MyUser user = GetIt.I.get<UserState>().currentUser!;
  final PhoneVerificationController controller =
      GetIt.I.get<PhoneVerificationController>();
  PhoneVerificationField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle(Color color, double size) =>
        TextStyle(fontWeight: FontWeight.w500, color: color, fontSize: size);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Observer(
            builder: (_) {
              return IntlPhoneField(
                  // Only numbers are allowed as input
                  keyboardType: TextInputType.number,
                  //Error message showed when the user is entering numbers
                  invalidNumberMessage: controller.errorPhoneVerification ??
                      appLocalizations.phoneIncorrect,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                      // Current number phone without prefix
                      labelText:
                          user.phone.isNotEmpty ? user.phone.substring(3) : "",
                      // Error message showed when the phoneNumber is complete
                      errorText: controller.errorPhoneVerification,
                      labelStyle: textStyle(Colors.black87, 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  initialCountryCode: 'ES',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (PhoneNumber? newTextValue) =>
                      controller.validatePhoneNumber(newTextValue),
                  onChanged: (PhoneNumber phone) {
                    controller.phoneNumber = phone;
                  },
                  onSubmitted: (_) => controller.sendSMS(context));
            },
          ),
          const SizedBox(height: 20),
          Observer(
            builder: (_) => CustomOutlinedButton(
              text: appLocalizations.verifyPhoneTitle,
              onPressed: controller.isValidPhone
                  ? () => controller.sendSMS(context)
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
